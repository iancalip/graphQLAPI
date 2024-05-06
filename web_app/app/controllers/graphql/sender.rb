module Graphql::Sender
  GRAPHQL_URL = URI("http://graphql_api:4000/graphql")

  def send_to_graphql(query_or_mutation)
    body = query_or_mutation.to_json
    headers = {"Content-Type": "application/json", Authorization: "Bearer #{token}"}
    HTTParty.post(GRAPHQL_URL, body:, headers:)
  end

  private

  def token
    data = {email: current_user.email, provider: current_user.provider}
    JWT.encode(data, ENV["JWT_SECRET"], "HS256")
  end
end
