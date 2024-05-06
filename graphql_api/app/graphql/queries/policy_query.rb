module Queries
  class PolicyQuery < Queries::BaseQuery
    type Types::PolicyType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      response = HTTParty.get("http://rest_api:5000/policies/#{id}",
        headers: {"Authorization" => "Bearer #{context[:current_user][:jwt]}"})
      JSON.parse(response.body)
    end
  end
end
