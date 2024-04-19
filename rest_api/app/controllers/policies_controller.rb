class PoliciesController < ApplicationController
  def index
    policies = Policy.all
    if policies
      render json: policies.map { |policy| policy_json(policy) }
    else
      render json: {error: "Policies not found"}, status: :not_found
    end
  end

  def show
    policy = Policy.find_by(id: params[:policy_id])
    if policy
      render json: policy_json(policy)
    else
      render json: {error: "Policy not found"}, status: :not_found
    end
  end

  private

  def policy_json(policy)
    {
      policy_id: policy.id,
      data_emissao: policy.issued_date,
      data_fim_cobertura: policy.end_coverage_date,
      status: policy.status,
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
  end
end
