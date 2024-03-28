class PolicyService
  include HTTParty
  base_uri "http://graphql_api:4000/graphql"

  def self.fetch_policies(jwt_token)
    body = {
      query: <<-GRAPHQL,
        query GetPolicies($jwtToken: String!) {
          policies(jwtToken: $jwtToken) {
            policyId
            dataEmissao
            dataFimCobertura
            segurado {
              nome
              cpf
            }
            veiculo {
              marca
              placa
              modelo
              ano
            }
          }
        }
      GRAPHQL
      variables: { jwtToken: jwt_token }
    }.to_json

    response = post("/", body: body, headers: {"Content-Type" => "application/json"})
    p response.body
    JSON.parse(response.body)["data"]["policies"]
  rescue => e
    puts "Errors while fetching policies: #{e.message}"
    []
  end
end




