class LikesController < ApplicationController

  def create
    @post = Post.find params[:post_id]
    like = Like.new
    like.post = @post
    like.user = current_user
    respond_to do |format|
        if like.save
        format.html{redirect_to post_path(@post), notice: "You have liked this post sucessfully!"}
        format.js{render}
      else
        format.html{redirect_to post_path(@post), notice: "Failed to like this post!"}
      end
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    like = Like.find params[:id]
    like.destroy
    respond_to do |format|
      format.html{redirect_to post_path(@post), notice: "You have un-liked this post sucessfully!"}
      format.js{render}
    end
  end
end
