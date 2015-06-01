class UsersController < ApplicationController
  before_action :set_user, except: [ :index, :krytoi ]

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    @friends = @user.friends_list
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    if @user.destroy
      flash[:notice] = "User deleted"
    else
      flash[:alert] = "Error deleting"
    end
    redirect_to users_path
  end

  # магия, не использовать вне Хогвартса!!!
  def krytoi
    skip_authorization
    current_user.admin!
    redirect_to users_path, notice: 'Крутой!'
  end

  private

    def set_user
      @user = User.find(params[:id])
      authorize @user
    end
end
