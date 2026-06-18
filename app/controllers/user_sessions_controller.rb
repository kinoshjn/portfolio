class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])&.authenticate(params[:password])

    if @user
      session[:user_id] = @user.id
      redirect_to root_path, status: :see_other
    else
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
