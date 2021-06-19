class UsersController < ApplicationController
  def show
    if params[:id]
      @user = User.find(params[:id])

      redirect_to profile_path
    else
      @user = current_user

      redirect_to profile_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :description)
  end
end
