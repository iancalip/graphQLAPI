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
            issuedDate: "2024-01-06",
            endCoverageDate: "2025-05-22",
            insured: {
              name: "John Silva",
              cpf: "001.002.003-90"
            },
            vehicle: {
              brand: "Fiat",
              model: "Uno 1.0",
              year: "2020",
              plate: "ABC-1234"
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
