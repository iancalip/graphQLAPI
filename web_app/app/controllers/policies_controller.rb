class PoliciesController < ApplicationController
  def index
    jwt_token = cookies[:jwt_token]
    @policies = PolicyService.fetch_policies(jwt_token) || []
  end
end
