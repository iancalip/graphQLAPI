class Policy < ApplicationRecord
  has_one :insured
  has_one :vehicle

  enum status: {
    pendente: 0,
    pago: 1
  }
end
