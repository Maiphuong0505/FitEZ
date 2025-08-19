class WorkoutSessionsController < ApplicationController
  before_action :set_workout_session, only: %i[show]
  before_action :set_client, only: %i[create]

  def show
    authorize @workout_session
    @session_exercises = @workout_session.session_exercises.any? ? @workout_session.session_exercises : []
    @session_exercise = SessionExercise.new
    @comment = Comment.new
  end

  def create
    @workout_session = WorkoutSession.new(workout_session_params)
    authorize @workout_session
    if @workout_session.save
      redirect_to workout_session_path(@workout_session), notice: "Workout session created successfully."
    else
      # render client show page if workout plan is invalid
      @workout_plans = @client.workout_plans_as_client
      @body_stat = BodyStat.new
      @workout_plan = WorkoutPlan.new
      render "clients/show", status: :unprocessable_entity
    end
  end

  # Method to copy existing session
  def copy
    original_session = WorkoutSession.find(params[:id])
    copied_sessions = original_session.deep_clone include: :session_exercises
    # copied_session = original_session.dup
    # copied_session.session_name = "Copy of #{original_session.session_name}"
    # copied_session.date_time =
    # copied_session.save
  end

  private

  def set_workout_session
    @workout_session = WorkoutSession.find(params[:id])
  end

  def set_client
    workout_plan = WorkoutPlan.find(params[:workout_plan_id])
    @client = User.find(workout_plan.client_id)
  end

  def workout_session_params
    params.require(:workout_session).permit(:session_name, :date_time, :duration, :with_trainer, :workout_plan_id)
  end
end
