module ApplicationHelper

  def user_like
    @user_like ||= @post.like_for(current_user) if session[:user_id]
  end

end
