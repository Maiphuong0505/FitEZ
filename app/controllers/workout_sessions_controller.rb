class WorkoutSessionsController < ApplicationController
  before_action :set_workout_session, only: %i[show]

  def show
    # authorize @workout_session
    @session_exercises = @workout_session.session_exercises if @workout_session.session_exercises.any?
    @session_exercise = SessionExercise.new
  end

  private

  def set_workout_session
    @workout_session = WorkoutSession.find(params[:id])
  end
end
