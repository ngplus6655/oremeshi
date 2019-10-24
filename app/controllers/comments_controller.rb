class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    post_id = comment_params[:post_id]
    @post = Post.find(post_id)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      render template: "posts/show"
    end

  end

  private
  def comment_params
    params.require(:comment).permit([:content, :post_id])
  end
end
