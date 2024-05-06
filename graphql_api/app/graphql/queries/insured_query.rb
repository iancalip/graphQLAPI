module Queries
  class InsuredQuery < Queries::BaseQuery
    type Types::InsuredType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      response = HTTParty.get("http://rest_api:5000/insureds/#{id}",
        headers: {"Authorization" => "Bearer #{context[:current_user][:jwt]}"})
      JSON.parse(response.body)
    end
  end
end
