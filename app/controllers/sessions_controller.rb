require "digest"

class SessionsController < ApplicationController
  def new
    redirect_to jobs_path, notice: "You are already logged in." if logged_in?
  end

  def create
    if valid_login?(submitted_username, submitted_password)
      reset_session
      session[:admin_logged_in] = true
      redirect_to jobs_path, notice: "Logged in successfully."
    else
      Rails.logger.warn(
        "Admin login failed username_match=#{username_match?(submitted_username)} " \
        "password_match=#{password_match?(submitted_password)} " \
        "submitted_username=#{normalize_username(submitted_username).inspect} " \
        "expected_username=#{normalize_username(admin_username).inspect}"
      )
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully."
  end

  private

  def submitted_username
    params[:username].presence || params.dig(:session, :username).presence || params.dig(:form, :username).presence
  end

  def submitted_password
    params[:password].presence || params.dig(:session, :password).presence || params.dig(:form, :password).presence
  end

  def valid_login?(username, password)
    credential_pairs.any? do |expected_username, expected_password|
      pair_username_match?(username, expected_username) && pair_password_match?(password, expected_password)
    end
  end

  def username_match?(username)
    pair_username_match?(username, admin_username)
  end

  def password_match?(password)
    pair_password_match?(password, admin_password)
  end

  def pair_username_match?(submitted, expected)
    secure_compare_digest(normalize_username(submitted), normalize_username(expected))
  end

  def pair_password_match?(submitted, expected)
    secure_compare_digest(normalize_secret(submitted), normalize_secret(expected))
  end

  def credential_pairs
    pairs = [[default_admin_username, default_admin_password]]
    pairs << [env_admin_username, env_admin_password] if env_admin_username.present? && env_admin_password.present?
    pairs.uniq
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
    env_admin_username.presence || default_admin_username
  end

  def admin_password
    env_admin_password.presence || default_admin_password
  end

  def env_admin_username
    ENV["ADMIN_USERNAME"].presence
  end

  def env_admin_password
    ENV["ADMIN_PASSWORD"].presence
  end

  def default_admin_username
    "Linc"
  end

  def default_admin_password
    "Recruitment2026$$"
  end
end
