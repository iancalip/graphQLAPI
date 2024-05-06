require "rails_helper"

RSpec.describe "Policies", type: :request do
  let!(:policy) { create(:policy) }
  describe "GET /policies/:id" do
    it "returns the policy information" do
      get "/policies/#{policy.id}"

      expect(response).to have_http_status(200)
      expect(json["policy_id"]).to eq policy.id
      expect(json["issued_date"]).to eq("2024-01-06")
      expect(json["end_coverage_date"]).to eq("2025-05-22")
      expect(json["insured"]["name"]).to eq("John Silva")
      expect(json["insured"]["cpf"]).to eq("001.002.003-90")
      expect(json["vehicle"]["brand"]).to eq("Fiat")
      expect(json["vehicle"]["model"]).to eq("Uno 1.0")
      expect(json["vehicle"]["plate"]).to eq("ABC-1234")
      expect(json["vehicle"]["year"]).to eq("2020")
    end
  end

  def json
    JSON.parse(response.body)
  end
end
