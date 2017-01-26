class SessionsController < ApplicationController

include SessionHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to robots_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session_logout
    redirect_to robots_path
  end

end