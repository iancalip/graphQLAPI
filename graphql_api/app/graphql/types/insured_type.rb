module Types
  class InsuredType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :cpf, String, null: false
  end
end
