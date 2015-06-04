class UsersController < ApplicationController
  before_action :set_user, except: [ :index, :krytoi ]

  def index
    @users = User.all.page params[:page]
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
      flash[:notice] = t('messages.deleted')
    else
      flash[:alert] = t('messages.cant_delete')
    end
    redirect_to users_path
  end

  # магия, не использовать вне Хогвартса!!!
  # TODO: чето сделать другое?
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
