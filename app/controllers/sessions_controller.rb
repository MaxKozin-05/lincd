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
    secure_compare_digest(normalize_username(username), normalize_username(admin_username)) &&
      secure_compare_digest(normalize_secret(password), normalize_secret(admin_password))
  end

  def secure_compare_digest(input, expected)
    ActiveSupport::SecurityUtils.secure_compare(
      Digest::SHA256.hexdigest(input.to_s),
      Digest::SHA256.hexdigest(expected.to_s)
    )
  end

  def normalize_username(value)
    normalize_secret(value).downcase
  end

  def normalize_secret(value)
    value.to_s.strip.gsub(/\A['"]|['"]\z/, "")
  end

  def admin_username
    ENV["ADMIN_USERNAME"].presence || "Linc"
  end

  def admin_password
    ENV["ADMIN_PASSWORD"].presence || "Recruitment2026$$"
  end
end
