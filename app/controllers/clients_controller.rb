class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show]
  def index
    @users = policy_scope(User)
    # skip_authorization_check
    @my_clients = User.my_clients(current_user.id)
    # @my_clients = clients.select do |client|
    #   trainer_ids = client.workout_plans_as_client.map(&:trainer_id)
    #   trainer_ids.include?(current_user.id)
    # end
  end

  def show
    # authorize @user
    @weight_data = set_weight_data
    @chart_options = set_chart_options
    @workout_plans = @client.workout_plans_as_client
    @body_stat = BodyStat.new
  end

  private

  def set_client
    @client = User.find(params[:id])
  end

  def set_weight_data
    {
      labels: @client.body_stats.map(&:timestamp),
      datasets: [{
        label: 'Weight',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: @client.body_stats.map(&:weight)
      }]
    }
  end

  def set_chart_options
    {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  end
end
