class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    policy_id = params[:policy_id]
    url = "http://rest_api:5000/policies/#{policy_id}"
    Rails.logger.info "URL: #{url}"
    response = HTTParty.get(url)

    if response.ok?
      policy_data = JSON.parse(response.body)
      customer = Stripe::Customer.create(
        email: current_user.email,
        description: "Customer id: #{current_user.id}"
      )

      session = Stripe::Checkout::Session.create(
        customer: customer.id,
        payment_method_types: ["card"],
        line_items: [{
          price: "price_1P431OKmqF3g59MYkx0cBY4r",
          quantity: 1
        }],
        mode: "payment",
        success_url: payments_success_url(policy_id: policy_id),
        cancel_url: payments_cancel_url
      )
      redirect_to session.url, allow_other_host: true
    else
      flash[:error] = "Policy not found"
      redirect_to root_path
    end
  end

  def success
    policy_id = params[:policy_id]
    update_response = HTTParty.patch("http://rest_api:5000/policies/#{policy_id}",
      body: {status: "pago"}.to_json,
      headers: {"Content-Type" => "application/json"})

    if update_response.ok?
      flash[:notice] = "Payment successfully made and policy updated"
    else
      flash[:alert] = "Payment was successful but failed to update policy status"
    end
    redirect_to root_url
  end

  def cancel
    flash[:error] = "Payment was cancelled"
    redirect_to root_url
  end
end
