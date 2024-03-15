module Resolvers
  class PolicyResolver < Resolvers::BaseResolver
    type Types::PolicyType, null: false

    argument :policy_id, ID, required: true

    def resolve(policy_id:)
      response = HTTParty.get("http://rest_api:5000/policies/#{policy_id}")
      JSON.parse(response.body)
    end
  end
end
