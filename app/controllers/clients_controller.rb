class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show]
  def index
    @clients = policy_scope(User)
    @my_clients = User.my_clients(current_user.id)
  end

  def show
    authorize @client
    @workout_plans = @client.workout_plans_as_client
    @body_stat = BodyStat.new
  end

  private

  def set_client
    @client = User.find(params[:id])
  end
end
