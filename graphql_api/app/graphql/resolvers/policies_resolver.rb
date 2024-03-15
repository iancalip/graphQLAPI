module Resolvers
  class PoliciesResolver < Resolvers::BaseResolver
    type [Types::PolicyType], null: false

    def resolve
      response = HTTParty.get("http://rest_api:5000/")
      JSON.parse(response.body)
    end
  end
end
