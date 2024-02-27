module Mutations
  class CreatePolicy < BaseMutation
    argument :issued_date, GraphQL::Types::ISO8601Date, required: true
    argument :end_coverage_date, GraphQL::Types::ISO8601Date, required: true
    argument :insured, Types::InsuredInputType, required: true
    argument :vehicle, Types::VehicleInputType, required: true

    type Types::PolicyType

    def resolve(issued_date:, end_coverage_date:, insured:, vehicle:)
      policy_data = {
        data_emissao: issued_date,
        data_fim_cobertura: end_coverage_date,
        segurado: {
          name: insured[:nome],
          cpf: insured[:cpf]
        },
        veiculo: {
          brand: vehicle[:marca],
          model: vehicle[:modelo],
          year: vehicle[:ano],
          plate: vehicle[:placa]
        }
      }

      queue = Bunny.new(hostname: "rabbitmq", port: "5672", vhost: "/", user: "guest", password: "guest")
      queue.start
      channel = queue.create_channel
      exchange = channel.default_exchange
      exchange.publish(policy_data.to_json, routing_key: "policy_created")
      queue.close
    end
  end
end
