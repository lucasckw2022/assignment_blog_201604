class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
    end
    helper_method :current_user

    def user_signed_in?
      session[:user_id].present?
    end
    helper_method :user_signed_in?

  def authenticate_user!
    redirect_to root_path, notice: "Please Sign In!" unless user_signed_in?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_full_name
    user ? user.full_name : "Unknown User"
  end
  helper_method :user_full_name

end
