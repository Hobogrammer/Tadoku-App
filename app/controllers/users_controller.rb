class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(user_params[:id])
  end

  def update
  end

  private

    def user_params
      params.require(:user).permit(:id, :profile_img, :name, :timezone)
    end

end
