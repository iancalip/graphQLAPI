module Queries
  class PoliciesQuery < Queries::BaseQuery
    type [Types::PolicyType], null: false

    def resolve
      response = HTTParty.get("http://rest_api:5000/",
        headers: {"Authorization" => "Bearer #{context[:current_user][:jwt]}"})
      data = JSON.parse(response.body)
      puts "Received data: #{data}"
      data
    rescue JSON::ParserError => e
      puts "Error while parsing response: #{e.message}"
      []
    end
  end
end
