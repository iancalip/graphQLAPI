module Types
  class PolicyType < Types::BaseObject
    field :policy_id, ID, null: false
    field :data_emissao, GraphQL::Types::ISO8601Date
    field :data_fim_cobertura, GraphQL::Types::ISO8601Date
    field :segurado, Types::InsuredType
    field :veiculo, Types::VehicleType
  end
end
