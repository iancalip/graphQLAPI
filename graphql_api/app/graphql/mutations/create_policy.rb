module Mutations
  class CreatePolicy < Mutations::BaseMutation
    argument :policy, Types::PolicyInputType, required: true

    field :result, String, null: false

    def resolve(policy:)
      queue = Bunny.new(hostname: "rabbitmq", port: "5672", vhost: "/", user: "guest", password: "guest")
      queue.start
      channel = queue.create_channel
      exchange = channel.default_exchange
      exchange.publish(policy.to_json, routing_key: "policy_created")
      queue.close
      {"result" => "OK"}
    rescue => exception
      raise GraphQL::ExecutionError.new(exception.message)
    end
  end
end
