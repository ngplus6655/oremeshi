class UsersController < ApplicationController

  before_action :admin_required, only: [:edit, :update, :destroy]

  def index
    @users = User.all.order(:name).page(params[:page]).per(20)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: params[:id]).order(updated_at: "DESC").page(params[:page]).per(12)
    @likes = @user.liked_posts.order(updated_at: "DESC").page(params[:page]).per(12)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザの登録に成功しました。"
      cookies.signed[:user_login_id] = @user.login_id
      redirect_to "/account"
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザの編集に成功しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの編集に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザを削除しました。"
    redirect_to '/users'
  end

  private

  def user_params
    params.require(:user).permit(:name, :login_id, :password, :password_confirmation, :name, :gender, 
                       :birthday, :prefecture, :introduce, :taste, :admin, :avatar)
  end


end
