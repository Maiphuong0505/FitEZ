class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show]
  def index
    @users = policy_scope(User)
    @my_clients = User.my_clients(current_user.id)
    # @my_clients = clients.select do |client|
    #   trainer_ids = client.workout_plans_as_client.map(&:trainer_id)
    #   trainer_ids.include?(current_user.id)
    # end
  end

  def show
    # authorize @user
    @workout_plans = @client.workout_plans_as_client
    @body_stat = BodyStat.new
  end

  private

  def set_client
    @client = User.find(params[:id])
  end
end
