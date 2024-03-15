class PolicyService
  include HTTParty
  base_uri "http://graphql_api:4000/graphql"

  def self.fetch_policies
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

    response = post("/", body: query.to_json, headers: {"Content-Type" => "application/json"})
    p response.body
    JSON.parse(response.body)["data"]["policies"]
  rescue => e
    puts "Erros while fetching policies: #{e.message}"
    []
  end
end
