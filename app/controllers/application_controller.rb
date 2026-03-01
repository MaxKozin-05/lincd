class ApplicationController < ActionController::Base
  helper_method :logged_in?

  private

  def logged_in?
    session[:admin_logged_in] == true
  end

  def authenticate_admin!
    return if logged_in?

    redirect_to login_path, alert: "Please log in to continue."
  end
end
