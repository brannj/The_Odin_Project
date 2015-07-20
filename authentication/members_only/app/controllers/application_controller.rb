class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Before filters.

    # Confirms logged in user.
    def logged_in_user
      unless logged_in?
        # store_location
        flash[:danger] = "Please login to access."
        redirect_to(root_url)
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    # Confrims admin.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
