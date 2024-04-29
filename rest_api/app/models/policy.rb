class Policy < ApplicationRecord
  has_one :insured
  has_one :vehicle

  accepts_nested_attributes_for :vehicle, :insured
  enum status: {pending: 0, active: 1}
end
