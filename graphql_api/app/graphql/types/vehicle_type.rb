module Types
  class VehicleType < Types::BaseObject
    field :placa, String, null: false
    field :modelo, String, null: false
    field :ano, String, null: false
    field :marca, String, null: false
  end
end
