class PaymentsController < ApplicationController
  def new
    render "payments/new"
  end

  def success
    redirect_to policies_path, notice: "Compra concluída com sucesso!"
  end

  def cancel
    redirect_to policies_path, notice: "Falha ao efetuar pagamento!"
  end

  private

  def live_confirm
    ActionCable.server.broadcast("PaymentUpdatesChannel", params.to_json)
  end
end
