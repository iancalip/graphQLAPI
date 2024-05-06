module Queries
  class InsuredsQuery < Queries::BaseQuery
    type [Types::InsuredType], null: false

    def resolve
      response = HTTParty.get("http://rest_api:5000/insureds",
        headers: {"Authorization" => "Bearer #{context[:current_user][:jwt]}"})
      JSON.parse(response.body)
    end
  end
end
