module Types
  class PolicyInputType < Types::BaseInputObject
    argument :data_emissao, GraphQL::Types::ISO8601Date, required: true
    argument :data_fim_cobertura, GraphQL::Types::ISO8601Date, required: true
    argument :segurado, Types::InsuredInputType, required: true
    argument :veiculo, Types::VehicleInputType, required: true
  end
end
