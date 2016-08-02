class UsersController < ApplicationController
  # setting default user, based on the id
  before_action :set_user,       only:   [:show, :edit, :update, :destroy]

  # check if already logged in
  before_action :require_login,  only:   [:show, :edit, :update, :destroy]

  # check if correct user
  before_action :correct_user,   only:   [:edit, :update]

  # check if needs log out again
  before_action :require_logout, only: [:new]

  # Give admin destroy rights
  before_action :admin_user,     only: :destroy

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @products = Product.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
     @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(permitted_user_params)

    respond_to do |format|
      if @user.save
        @user.send_activation_email
        format.html { redirect_to @user, notice: 'Please check your email to activate your account.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Profile updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permitted_user_params
      params.require(:user).permit(:name, :email, :address, :password, :cc_number, :photo_url, :cover_url)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])

      unless current_user?(@user)
        flash[:warning] = "Bitch you a narc?!"
        redirect_to root_url
      end
    end

    def require_logout
      if logged_in?
        flash[:warning] = "You must logged out to create a new user"
        redirect_to(root_url)
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
