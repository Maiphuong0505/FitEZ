class QuestionsController < ApplicationController
  before_action :set_workout_session, only: %i[create]

  def create
    @question = Question.new(question_params)
    @question.workout_session = @workout_session
    @question.user = current_user
    authorize @question
    if @question.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:questions, partial: "questions/question",
                                                               locals: { question: @question})
        end
        format.html { redirect_to workout_session_path(@workout_session) }
      end
    else
      @session_exercises = @workout_session.session_exercises.any? ? @workout_session.session_exercises : []
      @session_exercise = SessionExercise.new
      @comment = Comment.new
      @questions = current_user.questions
      render "workout_sessions/show", status: :unprocessable_entity
    end
  end

  private

  def set_workout_session
    @workout_session = WorkoutSession.find(params[:workout_session_id])
  end

  def question_params
    params.require(:question).permit(:user_question)
  end
end
