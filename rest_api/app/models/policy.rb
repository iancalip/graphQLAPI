class Policy < ApplicationRecord
  has_one :insured
  has_one :vehicle

  enum status: {pending: 0, active: 1}
end
