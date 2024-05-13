class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request

  private

  def authenticate_request
    auth_header = request.headers["Authorization"]
    token = auth_header.split(" ").last if auth_header
    payload, = JWT.decode(token, ENV["JWT_SECRET"], true, {algorithm: "HS256"})[0]
    @current_user = {payload: payload, jwt: token}
  rescue JWT::DecodeError => e
    puts "Error while decoding token: #{e.message}"
    render json: {errors: "Invalid Token"}, status: :unauthorized
  end

  attr_reader :current_user
end
