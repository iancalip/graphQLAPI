module Mutations
  class CreatePolicy < Mutations::BaseMutation
    argument :policy, Types::PolicyInputType, required: true

    field :result, String, null: false

    def resolve(policy:)
      policy_data = {
        issued_date: policy[:data_emissao],
        end_coverage_date: policy[:data_fim_cobertura],
        status: policy[:data_status],
        insured: {
          name: policy[:segurado][:nome],
          cpf: policy[:segurado][:cpf]
        },
        vehicle: {
          brand: policy[:veiculo][:marca],
          model: policy[:veiculo][:modelo],
          year: policy[:veiculo][:ano],
          plate: policy[:veiculo][:placa]
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
