class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], :per_page=>1)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) #{"name"=>"myName", "email"=>"my@email.com", "password"=>"123123", "password_confirmation"=>"123123"}    
    if @user.save
      log_in @user
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # redirect_to user_url(@user) = Get /users/3 = Get user_path(user) = show action, also think about user_path(@user)
      # user_path(@user) = "/users/1"
      # user_url(@user) = "http://localhost:3000/users/1"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]= "Profile updated"
      redirect_to @user
      # handle a successful update
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location  # in helpers/sessions_helper.rb, for friendly forwarding
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) # unless @user == current_user 
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
