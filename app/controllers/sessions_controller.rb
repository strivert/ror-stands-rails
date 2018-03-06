class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user # log_in is from ../helpers/sessions_helper.rb
      redirect_to current_user # user_url(user) => show action
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out # log_out is from ../helpers/sessions_helper.rb
    redirect_to root_url
  end
end
