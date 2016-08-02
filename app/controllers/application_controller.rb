class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  private
    # Confirms a logged-in user.
    def require_login
      unless logged_in?
        store_location
        flash[:danger] = "Bitch, you gotta log in."
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user && current_user.admin?
    end
end
