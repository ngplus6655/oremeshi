class PostsController < ApplicationController

  before_action :login_required, only: [:new, :create, :edit, :update]

  def index
    @posts = Post.all.order(updated_at: "DESC").page(params[:page]).per(12)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:successs] = "俺飯の投稿に成功しました。"
      redirect_to @post
    else
      flash.now[:danger] = "俺飯の投稿に失敗しました。"
      render "new"
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "#{@post.title} を編集しました。"
      redirect_to @post
    else
      flash.now[:danger] = "#{@post.title} を編集できませんでした。"
      render "edit"
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:success] = "#{@post.title} を削除しました。"
    redirect_to "/users/#{current_user.id}"
  end

  def search
    @query =  Date.civil(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    @posts = Post.search(@query).order(updated_at: "DESC").page(params[:page]).per(12)
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :review, :price, :user_id,
    post_pictures_attributes: [:name])
  end

end
