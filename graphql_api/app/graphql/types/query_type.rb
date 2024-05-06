module Types
  class QueryType < Types::BaseObject
    field :policy, resolver: Queries::PolicyQuery
    field :policies, resolver: Queries::PoliciesQuery
    field :vehicle, resolver: Queries::VehicleQuery
    field :vehicles, resolver: Queries::VehiclesQuery
    field :insured, resolver: Queries::InsuredQuery
    field :insureds, resolver: Queries::InsuredsQuery
  end
end
