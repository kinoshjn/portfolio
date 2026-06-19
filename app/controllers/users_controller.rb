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
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end
end
