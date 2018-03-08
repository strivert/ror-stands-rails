class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper  #  so that we can use all functions of SessionsHelper in not only views but also ALL CONTROLLERS - all controllers

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
