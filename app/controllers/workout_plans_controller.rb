class WorkoutPlansController < ApplicationController
  before_action :set_client, only: %i[create]

  def create
    @workout_plan = WorkoutPlan.new(workout_plan_params)
    @workout_plan.trainer_id = current_user.id
    authorize @workout_plan
    if @workout_plan.save
      redirect_to client_path(@client), notice: "Workout plan created successfully."
    else
      # render client show page if workout plan is invalid
      @workout_plans = @client.workout_plans_as_client
      @body_stat = BodyStat.new
      @workout_session = WorkoutSession.new
      render "clients/show", status: :unprocessable_entity
    end
  end

  private

  def set_client
    @client = User.find(params[:client_id])
  end

  def workout_plan_params
    params.require(:workout_plan).permit(:starting_date, :ending_date, :client_id)
  end
end
