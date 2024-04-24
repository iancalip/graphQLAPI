class PoliciesController < ApplicationController
  before_action :set_policy, only: [:show, :update, :destroy]
  def index
    @policies = Policy.all
    if @policies
      render json: @policies.sort_by(&:id)
    else
      render json: {error: "Policies not found"}, status: :not_found
    end
  end

  def create
    @policy = Policy.new(policy_params)
    if @policy.save
      render json: @policy, status: :created
    else
      render json: @policy.errors, status: :unprocessable_entity
    end
  end

  def update
    if @policy.update(policy_params)
      render json: @policy
    else
      render json: @policy.errors, status: :unprocessable_entity
    end
  end

  def show
    if @policy
      render json: @policy
    else
      render json: {error: "Policy not found"}, status: :not_found
    end
  end

  def destroy
    @policy.destroy
  end

  private

  def set_policy
    @policy = Policy.find(params[:id])
  end

  def policy_params
    params.require(:policy).permit(:issued_date, :end_coverage_date, :status, :payment_id, :payment_link, :insured, :vehicle)
  end
end
