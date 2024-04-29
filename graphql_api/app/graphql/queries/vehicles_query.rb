module Queries
  class VehiclesQuery < Queries::BaseQuery
    type [Types::VehicleType], null: false

    def resolve
      response = HTTParty.get("http://rest_api:5000/vehicles",
        headers: {"Authorization" => "Bearer #{context[:current_user][:jwt]}"})
      JSON.parse(response.body)
    end
  end
end
