class PaymentsController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      description: "Customer id: #{current_user.id}"
    )

    Stripe::Checkout::Session.create(
      customer:,
      payment_method_types: ["card"],
      line_items: [{
        price: "price_1P431OKmqF3g59MYkx0cBY4r",
        quantity: 1
      }],
      mode: "subscription",
      success_url: payments_success_url,
      cancel_url: payments_cancel_url
    )
    redirect_to root_path
  end

  def success
    redirect_to root_url, notice: "Payment successfully made"
  end

  def cancel
    redirect_to root_url, notice: "Something went wrong, payment cancelled"
  end
end
