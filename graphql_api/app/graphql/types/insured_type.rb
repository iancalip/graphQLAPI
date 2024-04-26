module Types
  class InsuredType < Types::BaseObject
    field :name, String, null: false
    field :cpf, String, null: false
  end
end
