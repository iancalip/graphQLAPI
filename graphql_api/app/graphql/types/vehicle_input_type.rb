module Types
  class VehicleInputType < Types::BaseInputObject
    argument :placa, String, required: true
    argument :modelo, String, required: true
    argument :ano, String, required: true
    argument :marca, String, required: true
  end
end
