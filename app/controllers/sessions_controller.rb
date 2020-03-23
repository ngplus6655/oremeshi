class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(login_id: params[:login_id])
    if @user&.authenticate(params[:password])
      session[:login_id] = @user.login_id
      flash[:success] = "#{@user.name}としてログインしました。"
    else
      flash[:danger] = "名前とパスワードが一致しません。"
    end
    redirect_to :root
  end

  def destroy
    session[:login_id] = nil
    flash[:info] = "ログアウトしました。"
    redirect_to :root
  end


end
