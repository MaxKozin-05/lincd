require "digest"

class SessionsController < ApplicationController
  def new
    redirect_to jobs_path, notice: "You are already logged in." if logged_in?
  end

  def create
    if valid_login?(params[:username], params[:password])
      reset_session
      session[:admin_logged_in] = true
      redirect_to jobs_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully."
  end

  private

  def valid_login?(username, password)
    secure_compare_digest(username, admin_username) &&
      secure_compare_digest(password, admin_password)
  end

  def secure_compare_digest(input, expected)
    ActiveSupport::SecurityUtils.secure_compare(
      Digest::SHA256.hexdigest(input.to_s),
      Digest::SHA256.hexdigest(expected.to_s)
    )
  end

  def admin_username
    ENV.fetch("ADMIN_USERNAME", "Linc")
  end

  def admin_password
    ENV.fetch("ADMIN_PASSWORD", "Recruitment2026$$")
  end
end
