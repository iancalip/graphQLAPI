class PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :update, :destroy]
  def index
    policies = Policy.all
    if policies
      render json: policies.map { |policy| policy_json(policy) }
    else
      render json: {error: "Policies not found"}, status: :not_found
    end
  end

  def show
    if @policy
      render json: policy_json(policy)
    else
      render json: {error: "Policy not found"}, status: :not_found
    end
  end

  def update
    if @policy.update(policy_params)
      render json: policy_json(policy)
    else
      render json: {error: "Policy not updated"}, status: :unprocessable_entity
    end
  end

  private

  def set_policy
    @policy = Policy.find_by(id: params[:id])
  end

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

  def policy_params
    params.require(:policy).permit(:status)
  end
end
