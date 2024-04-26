module Types
  class VehicleType < Types::BaseObject
    field :plate, String, null: false
    field :model, String, null: false
    field :year, String, null: false
    field :brand, String, null: false
  end
end
