
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :find_post, only: [:edit,:update,:show,:destroy]
  before_action :find_owned_post, only: [:edit,:update,:destroy]

  def new
    @post = Post.new
    # @post.user = current_user
  end

  def create
    post_params = params.require(:post).permit([:title,:body,{tag_ids:[]}])
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "The post has been sucessfully created!"
    else
      flash[:alert] = "Failed to create post!"
      render :new
    end
  end

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    post_params = params.require(:post).permit([:title,:body,tag_ids:[]])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

  # def user_like
  #   @user_like ||= @post.like_for(current_user) if session[:user_id]
  # end
  # helper_method :user_like

  private

  # def user
  #   @post.user = current_user
  # end

  def find_post
    @post = Post.find params[:id]
  end

  def find_owned_post
    @post = current_user.posts.find params[:id]
  end

end
