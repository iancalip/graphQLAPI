require 'jwt'

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def authenticate_request!(jwt_token)
      jwt_secret = 'secret_key'
      begin
        JWT.decode(jwt_token, jwt_secret, true, { algorithm: 'HS256' })
      rescue JWT::DecodeError => e
        raise GraphQL::ExecutionError.new("Authentication failed: #{e.message}", extensions: { code: 'UNAUTHORIZED' })
      end
    end
  end
end
