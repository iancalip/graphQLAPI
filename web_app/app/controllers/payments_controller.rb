class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    policy_id = params[:policy_id]
    Rails.logger.info "POLICY ID: #{params[:policy_id]}"
    url = "http://rest_api:5000/policies/#{policy_id}"
    Rails.logger.info "URL: #{url}"
    response = HTTParty.get(url, headers: {"Authorization" => "Bearer #{session[:jwt]}"})

    if response.ok?
      JSON.parse(response.body)
      customer = Stripe::Customer.create(
        email: current_user.email,
        description: "Customer id: #{current_user.id}"
      )

      session = Stripe::Checkout::Session.create(
        customer: customer.id,
        payment_method_types: ["card"],
        line_items: [{
          price: "price_1P8SotKmqF3g59MYAA9dsfGv",
          quantity: 1
        }],
        mode: "payment",
        success_url: payments_success_payments_url(policy_id: policy_id),
        cancel_url: payments_cancel_payments_url
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
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{session[:jwt]}"
      })

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
