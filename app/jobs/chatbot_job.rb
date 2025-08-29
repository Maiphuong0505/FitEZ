class ChatbotJob < ApplicationJob
  include ActionView::Helpers
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

    @session_exercise = eval(new_content)
    return unless @session_exercise.is_a?(SessionExercise)

    @session_exercise.workout_session = @question.workout_session
    @session_exercise.exercise = nearest_exercises

    chatgpt_reasoning = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: reason_of_suggestion
      }
    )

    content_reason = chatgpt_reasoning["choices"][0]["message"]["content"]

    question.update(ai_answer: content_reason)

    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: question }
    )
    Turbo::StreamsChannel.broadcast_append_to(
      "question_#{@question.id}",
      target: dom_id(@question),
      partial: "workout_sessions/ai_exercise_form", locals: { workout_session: @question.workout_session, session_exercise: @session_exercise, scroll: false, exercise: @session_exercise.exercise }
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
    system_text += "3. Suggest numbers for load, repetitions and set of each exercise.
    Generate attributes for a new SessionExercise instance, but do not save it.
    Return it as Ruby code calling `SessionExercise.new(load: , repetitions: , set: )`.
    The data type for load is decimal, repetitions and set are integer. The unit for load is kg (don't include these in the code).
    The only response should be the Ruby code. Never apply markdown like backtick to the code. "
    system_text += "4. Never suggest an exercise that has the same name with any of the exercises that already existing in the current workout session.
    Here are the exercises you should use to answer the user's questions: "
    [nearest_exercises].each do |exercise|
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

  def reason_of_suggestion
    questions = @question.user.questions
    results = []

    system_text = "You are an assistant for a fitness client management webapp. Your main user is freelance personal trainer."

    results << { role: "system", content: system_text }

    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end

    final_question = "Give the reason why you suggest this #{@session_exercise.exercise.name} with this #{@session_exercise.load} kg, #{@session_exercise.repetitions},
    #{@session_exercise.set} for this #{@question.workout_session.session_name}. Be concise with the explanation. No longer than 50 words. Not markdown, just plain text."

    results << { role: "system", content: final_question }
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
    ).first
  end
end
