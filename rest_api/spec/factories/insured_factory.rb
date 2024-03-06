FactoryBot.define do
  factory :insured do
    sequence(:name) { "John Silva" }
    sequence(:cpf) { "001.002.003-90" }
  end
end
