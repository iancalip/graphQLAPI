module Types
  class PolicyInputType < Types::BaseInputObject
    argument :issued_date, GraphQL::Types::ISO8601Date, required: true
    argument :end_coverage_date, GraphQL::Types::ISO8601Date, required: true
    argument :status, Integer
    argument :payment_id, String
    argument :payment_link, String
    argument :insured, Types::InsuredInputType, required: true
    argument :vehicle, Types::VehicleInputType, required: true
  end
end
