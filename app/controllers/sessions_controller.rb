class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    redirect_to dashboard_path if authenticated?
  end

  def create
    email = params[:email_address] # Correction pour extraire directement les paramètres
    password = params[:password]   # Correction pour extraire directement les paramètres

    raise ArgumentError, "Email and password are required" unless email.present? && password.present?

    user = User.find_by(email_address: email)
    if user&.authenticate(password)
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
