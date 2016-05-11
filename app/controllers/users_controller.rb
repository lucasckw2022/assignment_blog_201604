class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name,:last_name,:email,
      :password,:password_confirmation])
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: "Created User Account Successfully"
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user_params = params.require(:user).permit([:first_name,:last_name,:email])
    @user = User.find params[:id]
    if @user.update user_params
      redirect_to root_path, notice: "Your Information has been updated"
    else
      flash[:alert] = "Your Information has not been saved"
      render :edit
  end
  end

  def change_password
    @user = User.find params[:user_id]
  end

  def change_password_update
    user_params = params.require(:user).permit([:password,:password_confirmation])
    old_password = params.require(:user).permit([:old_password])[:old_password]
    @user = User.find params[:user_id]
    # byebug

    #authenticate is to compate the () with the password_digest field
    if @user.authenticate(old_password)
      if @user.update user_params
      redirect_to root_path, notice: "Your Information has been updated"
      else
        render :change_password
    end
    else
      flash[:alert] = "Wrong Passwords"
      render :change_password
    end
  end

end
