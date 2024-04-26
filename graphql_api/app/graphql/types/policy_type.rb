module Types
  class PolicyType < Types::BaseObject
    field :id, ID, null: false
    field :issued_date, GraphQL::Types::ISO8601Date
    field :end_coverage_date, GraphQL::Types::ISO8601Date
    field :status, Integer
    field :payment_id, String
    field :payment_link, String
    field :insured, Types::InsuredType
    field :vehicle, Types::VehicleType
  end
end
