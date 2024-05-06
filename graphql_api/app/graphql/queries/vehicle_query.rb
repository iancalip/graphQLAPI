module Queries
  class VehicleQuery < Queries::BaseQuery
    type Types::VehicleType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      response = HTTParty.get("http://rest_api:5000/vehicles/#{id}",
        headers: {"Authorization" => "Bearer #{context[:current_user][:jwt]}"})
      JSON.parse(response.body)
    end
  end
end
