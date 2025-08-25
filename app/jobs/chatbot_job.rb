class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    human_content = new_content.match(/<human>(.*?)<\/human>/m)
    human_response = human_content[1].strip
    # ai_json = new_content.match(/<output>(.*?)<\/output>/m)
    # json = ai_json[1].strip

    question.update(ai_answer: human_response)
    # question.update(json_output: json)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: question }
    )
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []

    system_text = "You are an assistant for a fitness client management webapp. Your main user is freelance personal trainer.
    1. Always be aware of the workout session you are working on. The id of the session is #{@question.workout_session.id}.
    The name of the session is #{@question.workout_session.session_name}."
    # about existing session exercises
    system_text += "2. Always be aware of all the session exercise that already exist in the current workout session.
    Here are all the existing session exercises: "
    @question.workout_session.session_exercises.each do |session_exercise|
      system_text += "EXERCISE #{session_exercise.exercise.id}: name: #{session_exercise.exercise.name},
      load: #{session_exercise.load}, repetitions: #{session_exercise.repetitions}, set: #{session_exercise.set}"
    end
    # to nearest_execises code as private method
    system_text += "3. Always response with 2 distinct sections. The first section has to be a human-friendly explanation with plain text,
    which is enclosed in <human> tags like html. The first section must say the name of the exercise, required equipment, suggested number of loads,
    suggested number of repetitions and sets, each in a full sentence without any markups. This section should also say a brief description in plain text of the exercise's starting position and execution.
    In the second section, construct a valid json enclosed in <output> tags like html, out of the information of exactly the same exercise, following the format below:
    ' Exercise name: ,
      Loads: ,
      Repetitions: ,
      Sets: ,
      Equipment: ,
      Starting postition: ,
      Execution: '"
    system_text += "4. Never suggest an exercise that has the same name with any of the exercises that already existing in the current workout session.
    5. If you don't know the answer, you can say 'I don't know'.
    Here are the exercises you should use to answer the user's questions: "
    nearest_exercises.each do |exercise|
      system_text += "EXERCISE #{exercise.id}, name: #{exercise.name}, equipment: #{exercise.equipment}, main muscles: #{exercise.main_muscles},
      starting position: #{exercise.starting_position}, execution: #{exercise.execution}"
    end
    results << { role: "system", content: system_text }

    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end

    return results
  end

  def nearest_exercises
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )
    question_embedding = response['data'][0]['embedding']
    return Exercise.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    ).first(2)
  end
end
