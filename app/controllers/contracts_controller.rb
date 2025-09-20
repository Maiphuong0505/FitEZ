class ContractsController < ApplicationController
  before_action :set_trainer, only: %i[create]

  def create
    @contract = Contract.new(contract_params)
    @contract.trainer_id = current_user.id
    authorize @contract
    if @contract.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:clients, partial: "clients/client",
                                                                       locals: { client: User.find(@contract.client_id), scroll: true })
        end
        format.html { redirect_to clients_path, notice: "Check your new client!" }
      end
    else
      @contract = Contract.new
      @clients = policy_scope(User)
      @my_clients = User.my_clients(current_user.id)
      render "clients/index", status: :unprocessable_entity
    end
  end

  private

  def set_trainer
    @trainer = current_user
  end

  def contract_params
    params.require(:contract).permit(:client_id)
  end

end
