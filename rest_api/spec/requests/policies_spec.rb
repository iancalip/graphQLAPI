require "rails_helper"

RSpec.describe "Policies", type: :request do
  let!(:policy) { create(:policy) }
  describe "GET /policies/:id" do
    it "returns the policy information" do
      get "/policies/#{policy.id}"

      expect(response).to have_http_status(200)
      expect(json["policy_id"]).to eq policy.id
      expect(json["data_emissao"]).to eq("2024-01-06")
      expect(json["data_fim_cobertura"]).to eq("2025-05-22")
      expect(json["segurado"]["nome"]).to eq("John Silva")
      expect(json["segurado"]["cpf"]).to eq("001.002.003-90")
      expect(json["veiculo"]["marca"]).to eq("Fiat")
      expect(json["veiculo"]["modelo"]).to eq("Uno 1.0")
      expect(json["veiculo"]["placa"]).to eq("ABC-1234")
      expect(json["veiculo"]["ano"]).to eq("2020")
    end
  end

  def json
    JSON.parse(response.body)
  end
end
