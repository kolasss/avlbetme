class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    p @user.friends[:vk_friends_ids]
    @bets = @user.bets
    @friends = @user.friends_list
    p @friends
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User deleted"
    else
      flash[:alert] = "Error deleting"
    end
    redirect_to users_path
  end

end
