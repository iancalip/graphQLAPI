# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def google_oauth2
    user = User.from_omniauth(auth)

    if user.present?
      sign_out_all_scopes
      flash[:success] = "Successfully authenticated from Google account."
      set_jwt_cookie_for(user)
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = "Authentication via Google failed."
      redirect_to new_user_session_path
    end
  end

  def cognito_idp
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      flash[:success] = "Successfully authenticated from Cognito account."
      set_jwt_cookie_for(user)
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = "Authentication via Cognito failed."
      redirect_to new_user_session_path
    end
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private

  def auth
    @auth ||= request.env["omniauth.auth"]
  end
end
