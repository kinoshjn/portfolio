class UsersController < ApplicationController
  layout "minimal"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, status: :see_other
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end
end
