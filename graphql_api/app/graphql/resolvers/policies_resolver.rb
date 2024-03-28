module Resolvers
  class PoliciesResolver < Resolvers::BaseResolver
    type [Types::PolicyType], null: false
    argument :jwt_token, String, required: true, description: "JWT Token for authentication"

    def resolve(jwt_token:)
      authenticate_request!(jwt_token)
      response = HTTParty.get("http://rest_api:5000/", headers: { "Authorization" => "Bearer #{jwt_token}" })
      JSON.parse(response.body)
    end
  end
end


