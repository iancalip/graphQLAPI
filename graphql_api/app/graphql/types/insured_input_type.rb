module Types
  class InsuredInputType < Types::BaseInputObject
    argument :name, String, required: true
    argument :cpf, String, required: true
  end
end
