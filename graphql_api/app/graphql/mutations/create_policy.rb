module Mutations
  class CreatePolicy < Mutations::BaseMutation
    argument :policy, Types::PolicyInputType, required: true

    field :result, String, null: false

    def resolve(policy:)
      policy_data = {
        issued_date: policy[:issued_date],
        end_coverage_date: policy[:end_coverage_date],
        status: policy[:status],
        payment_id: policy[:payment_id],
        payment_link: policy[:payment_link],
        insured: {
          name: policy[:insured][:name],
          cpf: policy[:insured][:cpf]
        },
        vehicle: {
          brand: policy[:vehicle][:brand],
          model: policy[:vehicle][:model],
          year: policy[:vehicle][:year],
          plate: policy[:vehicle][:plate]
        }
      }

      queue = Bunny.new(hostname: "rabbitmq", port: "5672", vhost: "/", user: "guest", password: "guest")
      queue.start
      channel = queue.create_channel
      exchange = channel.default_exchange
      exchange.publish(policy_data.to_json, routing_key: "policy_created")
      queue.close
      {"result" => "OK"}
    end
  end
end
