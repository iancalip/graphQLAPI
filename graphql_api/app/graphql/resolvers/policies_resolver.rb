module Resolvers
  class PoliciesResolver < Resolvers::BaseResolver
    type [Types::PolicyType], null: false

    def resolve
      response = HTTParty.get("http://rest_api:5000/",
        headers: {"Authorization" => "Bearer #{context[:current_user][:jwt]}"})
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      puts "Error while parsing response: #{e.message}"
      []
    end
  end
end
