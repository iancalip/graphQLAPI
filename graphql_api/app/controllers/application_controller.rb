class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request

  private

  def authenticate_request
    auth_header = request.headers["Authorization"]
    token = auth_header.split(" ").last if auth_header
    JWT.decode(token, ENV["JWT_SECRET"], true, {algorithm: "HS256"})
  rescue JWT::DecodeError => e
    render json: {errors: "Invalid Token"}, status: :unauthorized
  end
end
