class LikesController < ApplicationController
  before_action :set_variables
  def like
    @like = current_user.likes.create(post_id: params[:post_id])
  end

  def unlike
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
  end

  private
    def set_variables
      @post = Post.find(params[:post_id])
      @id_name = "#like-link-#{@post.id}"
    end
end
