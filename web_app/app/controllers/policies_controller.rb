class PoliciesController < ApplicationController
  def index
    @policies = PolicyService.fetch_policies
  end
end
