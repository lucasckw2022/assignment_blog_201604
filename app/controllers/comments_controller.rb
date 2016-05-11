class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comments, only: :destroy

  def create
    # @post = Post.find params[:post_id]
    comments_params = params.require(:comment).permit([:body])
    @comment = Comment.new comments_params
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html {redirect_to post_path(@post)}
        format.js {render}
      else
        format.hmtl {render "/posts/show"}
      end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = @post.comments.find params[:id]
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to post_path(@post)}
  end

  private

  def find_post
    @post = Post.find params[:post_id]
  end

  def find_comments
    @comment = @post.comments.find params[:id]
    redirect_to root_path unless can? :destroy, @comment
  end

end
