class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # log the user in and show log in message
        log_in user
        remember user
        redirect_back_or shop_path
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # display error message
      flash.now[:danger] = "Yo fam you sure that's your email and password?"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = 'See ya later smellagator'
    redirect_to root_url
  end
end
