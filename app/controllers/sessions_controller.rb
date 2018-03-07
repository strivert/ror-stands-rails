class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user # log_in is from ../helpers/sessions_helper.rb
      #remember user # remember is from ../helpers/sessions_helper.rb
      # if remember is checked = rmember(user) or if unchecked, forget(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      
      #redirect_to current_user # user_url(user) => show action
      redirect_back_or user # in helpers/sessions_helper.rb, for friendly forwarding
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? # log_out is from ../helpers/sessions_helper.rb, "if logged_in" => for first subtle
    redirect_to root_url
  end
end
