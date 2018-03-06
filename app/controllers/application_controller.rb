class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper  #  so that we can use all functions of SessionsHelper in not only views but also ALL CONTROLLERS - all controllers
end
