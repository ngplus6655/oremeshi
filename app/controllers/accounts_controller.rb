class AccountsController < ApplicationController
  before_action :login_required

  def show
    @user = current_user
    @posts = @user.posts.all.order(updated_at: "DESC").page(params[:page]).per(12)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.save
      flash[:success] = "プロフィールの編集を保存しました。"
      redirect_to :account
    else
      flash.now[:danger] = "プロフィールの編集の保存に失敗しました。"
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :login_id, :password, :password_confirmation, :name, :gender, 
                       :birthday, :prefecture, :introduce, :taste, :admin, :avatar)
  end
end
