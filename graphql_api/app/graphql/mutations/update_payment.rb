module Mutations
  class UpdatePayment < Mutations::BaseMutation
    argument :payment_data, Types::PaymentInputType, required: true

    field :result, String, null: false

    def resolve(payment_data:)
      queue = Bunny.new(hostname: "rabbitmq", port: "5672", vhost: "/", user: "guest", password: "guest").start
      channel = queue.create_channel
      exchange = channel.default_exchange
      exchange.publish(payment_data.to_json, routing_key: "payment_update")
      queue.close
      {"result" => "OK"}
    rescue => exception
      raise GraphQL::ExecutionError.new(exception.message)
    end
  end
end
