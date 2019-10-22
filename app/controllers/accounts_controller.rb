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
    @user = currenet_user
    @user.assign_attributes(params[:account])
    if @user.save
      flash[:notice] = "プロフィールの編集を保存しました。"
      redirect_to :account
    else
      render "edit"
    end
  end
end
