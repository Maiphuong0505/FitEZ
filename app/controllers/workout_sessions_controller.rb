class WorkoutSessionsController < ApplicationController
  before_action :set_workout_session, only: %i[show copy]
  before_action :set_client, only: %i[create copy]

  def show
    authorize @workout_session
    @session_exercises = @workout_session.session_exercises.any? ? @workout_session.session_exercises : []
    @session_exercise = SessionExercise.new
    @comment = Comment.new
  end

  # Method to copy existing session
  def copy
    @workout_session_copy = @workout_session.deep_clone include: :session_exercises
    @workout_session_copy.session_name = "#{@workout_session.session_name} (Copy)"
    @workout_session_copy.date_time = Time.current
    @workout_session_copy.id = nil
    authorize @workout_session_copy
    render :new, locals: { workout_session: @workout_session_copy, copy_from_id: @workout_session.id }
  end

  def create
    @workout_session = WorkoutSession.new(workout_session_params)
    authorize @workout_session
    if @workout_session.save
      if params[:copy_from_id].present?
        original = WorkoutSession.find(params[:copy_from_id])
        original.session_exercises.each do |exercise|
          @workout_session.session_exercises.create(exercise.attributes.except("id", "workout_session_id", "created_at", "updated_at"))
        end
      end
      redirect_to workout_session_path(@workout_session), notice: "Workout session created successfully."
    else
      # render client show page if workout plan is invalid
      @workout_plans = @client.workout_plans_as_client
      @body_stat = BodyStat.new
      @workout_plan = WorkoutPlan.new
      render "clients/show", status: :unprocessable_entity
    end
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
