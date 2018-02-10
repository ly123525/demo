class UsersController < ApplicationController
  layout 'session'
  skip_before_action :require_login
  def new
    @is_using_email = true
    @user = User.new
  end

  def create
    @is_using_email = (params[:user] and !params[:user][:email].nil? )
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :cellphone, :password, :password_confirmation, :remember_ )
  end
end