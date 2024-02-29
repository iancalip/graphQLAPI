class PoliciesController < ApplicationController
  def show
    policy = Policy.find_by(id: params[:policy_id])
    if policy
      policy_json = {
        policy_id: policy.id,
        data_emissao: policy.issued_date,
        data_fim_cobertura: policy.end_coverage_date,
        segurado: {
          nome: policy.insured.name,
          cpf: policy.insured.cpf
        },
        veiculo: {
          marca: policy.vehicle.brand,
          modelo: policy.vehicle.model,
          ano: policy.vehicle.year,
          placa: policy.vehicle.plate
        }
      }
      render json: policy_json
    else
      render json: {error: "Policy not found"}, status: :not_found
    end
  end
end
