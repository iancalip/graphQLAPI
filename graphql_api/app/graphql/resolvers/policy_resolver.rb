module Resolvers
  class PolicyResolver < Resolvers::BaseResolver
    type Types::PolicyType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      response = HTTParty.get("http://rest_api:5000/policies/#{id}")
      JSON.parse(response.body)
    end
  end
end
