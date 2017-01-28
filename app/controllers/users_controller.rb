class UsersController < ApplicationController
  include SessionHelper

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session_login @user
      redirect_to user_path(@user), :notice => "New User was saved"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), :notice => "User has been updated"
    else
      render "edit"
    end
  end

  def destroy
    session_logout
    user = User.find(params[:id])
    user.destroy
    redirect_to login_path, :alert => "User has been deleted"
  end


  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
