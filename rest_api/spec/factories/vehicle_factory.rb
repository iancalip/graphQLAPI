FactoryBot.define do
  factory :vehicle do
    sequence(:brand) { "Fiat" }
    sequence(:model) { "Uno 1.0" }
    sequence(:plate) { "ABC-1234" }
    sequence(:year) { "2020" }
  end
end
