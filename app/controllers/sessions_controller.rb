class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log the user in and show log in message
      log_in user
      remember user
      redirect_back_or user
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
