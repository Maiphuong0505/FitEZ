class BodyStatsController < ApplicationController
  before_action :set_client, only: %i[create]
  def create
    @body_stat = BodyStat.new(listing_params)
    @body_stat.user_id = @client.id
    if @body_stat.save
      redirect_to client_path(@client), notice: "Finally! Added!"
    else
      @workout_plans = @client.workout_plans_as_client
      render "clients/show", status: :unprocessable_entity
    end
  end

  private

  def set_client
    @client = User.find(params[:client_id])
  end

  def listing_params
    params.require(:body_stat).permit(:timestamp, :weight, :body_fat, :muscle_mass, :user_id)
  end
end
