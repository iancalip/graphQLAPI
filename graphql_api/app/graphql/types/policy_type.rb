module Types
  class PolicyType < Types::BaseObject
    field :id, ID, null: false
    field :issued_date, GraphQL::Types::ISO8601Date, null: false
    field :end_coverage_date, GraphQL::Types::ISO8601Date, null: false
    field :status, Integer, null: false
    field :payment_id, String, null: false
    field :payment_link, String, null: false
    field :insured, Types::InsuredType, null: false
    field :vehicle, Types::VehicleType, null: false
  end
end
