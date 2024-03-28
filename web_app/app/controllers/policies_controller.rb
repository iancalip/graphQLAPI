class PoliciesController < ApplicationController
  before_action :authenticate_user!
  def index
    @policies = PolicyService.fetch_policies(session[:jwt])
  end
end
