class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    result = Auth::Operation::CreateAccount.(params: user_params)
    render_result(result: result, path: login_users_path, notice: "You have successfully registered")
  end

  def perform_login
    result = Auth::Operation::Login.(params: login_params)
    render_result(result: result, path: spendings_path)
  end

  def logout
    session[:user_id] = nil
    redirect_to login_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login_params
    params.permit(:email, :password)
  end
end
