module Types
  class PolicyInputType < Types::BaseInputObject
    argument :issued_date, GraphQL::Types::ISO8601Date, required: true
    argument :end_coverage_date, GraphQL::Types::ISO8601Date, required: true
    argument :status, String, required: true
    argument :payment_id, String, required: true
    argument :payment_link, String, required: true
    argument :insured, Types::InsuredInputType, required: true
    argument :vehicle, Types::VehicleInputType, required: true
  end
end
