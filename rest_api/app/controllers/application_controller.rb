class ApplicationController < ActionController::Base
  before_action :authenticate_request

  private

  def authenticate_request
    auth_header = request.headers["Authorization"]
    unless auth_header
      render json: {errors: "Authorization header is missing"}, status: :unauthorized
      return
    end

    token = auth_header.split(" ").last

    if token.blank?
      render json: {errors: "Token not provided"}, status: :unauthorized
      return
    end

    begin
      payload, = JWT.decode(token, ENV["JWT_SECRET"], true, {algorithm: "HS256"})
      @current_user = payload
    rescue JWT::DecodeError => e
      render json: {errors: "Invalid Token: #{e.message}"}, status: :unauthorized
    end
  end

  attr_reader :current_user
end
