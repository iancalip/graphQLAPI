class PoliciesController < ApplicationController
  before_action :authenticate_user!
  include Graphql::Sender
  def index
    sleep(1)
    return nil if policies_list.nil?
    @policies = policies_list
  end

  def new
  end

  def create
    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [{
        price: "price_1P8SotKmqF3g59MYAA9dsfGv",
        quantity: 1
      }],
      mode: "payment",
      success_url: payments_success_url,
      cancel_url: payments_cancel_url
    )

    payment_id = session.id
    payment_url = session.url

    send_to_graphql(Graphql::Mutations.create_policy(params, payment_id, payment_url))

    redirect_to policies_path
  end

  def show
    redirect_to policies_path
  end

  private

  def policies_list
    response = send_to_graphql(Graphql::Queries.get_policies)
    return nil if response.parsed_response.dig("data", "policies").nil?
    response
      .parsed_response
      .dig("data", "policies")
      .map { |hash| hash.with_indifferent_access }
  end
end
