class PoliciesController < ApplicationController
  def show
    policy = Policy.find_by(id: params[:policy_id])
    p policy
    if policy
      render json: policy, include: [:insured, :vehicle]
    else
      render json: {error: "Policy not found"}, status: :not_found
    end
  end
end
