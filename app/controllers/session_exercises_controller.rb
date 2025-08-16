class SessionExercisesController < ApplicationController
  before_action :set_workout_session, only: %i[create]

  def create
    @session_exercise = SessionExercise.new(session_exercise_params)
    @session_exercise.workout_session = @workout_session
    authorize @session_exercise
    if @session_exercise.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:session_exercises, partial: "workout_sessions/exercise_display",
                                                                       locals: { session_exercise: @session_exercise })
        end
        format.html { redirect_to workout_session_path(@workout_session), notice: "Exercise added successfully" }
      end
    else
      @session_exercises = @workout_session.session_exercises if @workout_session.session_exercises.any?
      @comment = Comment.new
      render "workout_sessions/show", status: :unprocessable_entity
    end
  end

  private

  def set_workout_session
    @workout_session = WorkoutSession.find(params[:workout_session_id])
  end

  def session_exercise_params
    params.require(:session_exercise).permit(:exercise_id, :repetitions, :load, :set, :done)
  end
end
