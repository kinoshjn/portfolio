class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])&.authenticate(params[:password])

    if @user
      # ログイン計測用に追加    2026.6/26修正   <user.rb参照>
      @user.record_login!

      session[:user_id] = @user.id
      redirect_to root_path, status: :see_other
    else
      flash[:danger] = "ログインに失敗しました"
      redirect_to login_path, status: :see_other
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
