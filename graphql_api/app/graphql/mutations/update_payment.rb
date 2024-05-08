module Mutations
  class UpdatePayment < Mutations::BaseMutation
    argument :payment_data, Types::PaymentInputType, required: true
    field :result, String, null: false

    def resolve(payment_data:)
      p payment_data
      queue = Bunny.new(hostname: "rabbitmq", port: "5672", vhost: "/", user: "guest", password: "guest").start
      channel = queue.create_channel
      exchange = channel.default_exchange
      exchange.publish(policy.to_json, routing_key: "update_payment")
      queue.close
      {"result" => "OK"}
    rescue => exception
      raise GraphQL::ExecutionError.new(exception.message)
    end
  end
end
