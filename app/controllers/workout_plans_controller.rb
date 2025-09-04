class WorkoutPlansController < ApplicationController
  before_action :set_client, only: %i[create]

  def create
    date_range = params[:workout_plan][:starting_date].split(" to ")
    @workout_plan = WorkoutPlan.new(
      starting_date: date_range[0],
      ending_date: date_range[1],
      trainer_id: current_user.id,
      client_id: @client.id,
      scheduled_trainer_session: params[:workout_plan][:scheduled_trainer_session]
    )
    authorize @workout_plan
    if @workout_plan.save
      @workout_session = WorkoutSession.new
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:workout_plans, partial: "clients/workout_plan_display",
                                                                    locals: { workout_plans: @workout_plans, plan: @workout_plan, workout_session: @workout_session, workout_plan: @workout_plan })
        end
        format.html { redirect_to client_path(@client), notice: "Workout plan created successfully." }
      end
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
end
