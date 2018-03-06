class UsersController < ApplicationController
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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
