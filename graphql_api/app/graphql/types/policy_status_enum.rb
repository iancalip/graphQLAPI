module Types
  class PolicyStatusEnum < GraphQL::Schema::Enum
    value "PENDENTE", value: "pendente"
    value "PAGO", value: "pago"
  end
end
