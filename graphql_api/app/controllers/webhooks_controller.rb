class WebhooksController < ApplicationController
  skip_before_action :authenticate_request

  ENDPOINT_SECRET = ENV.fetch("WEBHOOK_ENDPOINT_SECRET", nil)

  def update
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]

    event = Stripe::Webhook.construct_event(
      payload, sig_header, ENDPOINT_SECRET
    )

    case event.type
    when "checkout.session.async_payment_failed"
      session = event.data.object
    when "checkout.session.async_payment_succeeded"
      session = event.data.object
    when "checkout.session.completed"
      session = event.data.object
      @payment_id = session.id
      @payment_status = session.status
      send_request(payment_update)
      Rails.logger.info "QUER: #{send_request(payment_update)}"
    when "checkout.session.expired"
      session = event.data.object
    else
      puts "Unhandle event type: #{event.type}"
    end
  end

  def payment_update
    {
      query: "mutation updatePaymentMutation(
        $payment_id: String!
        $status: String!
      ) {
        updatePayment (
          input: {
            paymentData:{
              paymentId: $payment_id
              status: $status
            }
          }
        ) { result }
      }",
      variables: {
        payment_id: @payment_id,
        status: "active"
      }
    }
  end

  def send_request(payment_update)
    jwt_token = generate_token
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{jwt_token}"
    }
    HTTParty.post(ENV.fetch("GRAPHQL_URL"), body: payment_update.to_json, headers:)
  end

  private

  def generate_token
    payload = {
      data: "service_user",
      exp: Time.now.to_i + 300
    }
    JWT.encode(payload, ENV["JWT_SECRET"], "HS256")
  end
end
