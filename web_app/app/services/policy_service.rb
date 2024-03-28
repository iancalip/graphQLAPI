class PolicyService
  include HTTParty
  base_uri "http://graphql_api:4000"

  def self.fetch_policies(jwt_token)
    query = {
      query: <<-GRAPHQL
        query {
          policies {
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
    }

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{jwt_token}"
    }

    response = post("/graphql", body: query.to_json, headers: headers)
    p response.body
    JSON.parse(response.body).dig("data", "policies") || []
  rescue => e
    puts "Erros while fetching policies: #{e.message}"
    []
  end
end
