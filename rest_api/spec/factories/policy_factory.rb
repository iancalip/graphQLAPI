FactoryBot.define do
  factory :policy do
    sequence(:issued_date) { "2024-01-06" }
    sequence(:end_coverage_date) { "2025-05-22" }

    after(:create) do |policy|
      create(:insured, policy: policy)
      create(:vehicle, policy: policy)
    end
  end
end
