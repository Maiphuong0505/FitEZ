class SessionExercisesController < ApplicationController
  before_action :set_workout_session, only: %i[create]

  def create
    @session_exercise = SessionExercise.new(session_exercise_params)
    @session_exercise.workout_session = @workout_session
    if @session_exercise.save
      redirect_to workout_session_path(@workout_session), notice: "Exercise added successfully"
    else
      @session_exercises = @workout_session.session_exercises if @workout_session.session_exercises.any?
      @session_exercise = SessionExercise.new
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
