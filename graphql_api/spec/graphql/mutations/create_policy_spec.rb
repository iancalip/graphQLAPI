require "rails_helper"

RSpec.describe "CreatePolicy Mutation", type: :request do
  it "creates a policy and returns OK" do
    post "/graphql", params: {query: create_policy_mutation}

    expect(response).to have_http_status(:success)
    expect(json["data"]["createPolicy"]["result"]).to eq("OK")
  end

  def create_policy_mutation
    <<~GQL
      mutation {
        createPolicy(input: {
          policy: {
            dataEmissao: "2024-01-06",
            dataFimCobertura: "2025-05-22",
            segurado: {
              nome: "John Silva",
              cpf: "001.002.003-90"
            },
            veiculo: {
              marca: "Fiat",
              modelo: "Uno 1.0",
              ano: "2020",
              placa: "ABC-1234"
            }
          }
        }) {
          result
        }
      }
    GQL
  end

  def json
    JSON.parse(response.body)
  end
end
