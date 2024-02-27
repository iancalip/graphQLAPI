module Types
  class InsuredInputType < Types::BaseInputObject
    argment :nome, String, required: true
    argument :cpf, String, required: true
  end
end
