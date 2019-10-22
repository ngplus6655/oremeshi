class SessionsController < ApplicationController
  def create
    @user = User.find_by(login_id: params[:login_id])
    if @user&.authenticate(params[:password])
      cookies.signed[:user_login_id] = @user.login_id
    else
      flash[:alert] = "名前とパスワードが一致しません。"
    end
    redirect_to :root
  end

  def destroy
    cookies.delete :user_login_id
    flash[:alert] = "ログアウトしました。"
    redirect_to :root
  end


end
