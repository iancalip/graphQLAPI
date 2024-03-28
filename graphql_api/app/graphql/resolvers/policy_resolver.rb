module Resolvers
  class PolicyResolver < Resolvers::BaseResolver
    type Types::PolicyType, null: false

    argument :policy_id, ID, required: true

    def resolve(policy_id:)
      jwt_token = context[:headers]['Authorization']&.split(' ')&.last
      authenticate_request!(jwt_token)

      response = HTTParty.get("http://rest_api:5000/policies/#{policy_id}", headers: { "Authorization" => "Bearer #{jwt_token}" })
      JSON.parse(response.body)
    end
  end
end
