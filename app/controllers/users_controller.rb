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

    @user_stats = {win: {}, lose: {}, sum: {}}
    @numeric_types = StakeType.numeric
    @numeric_types.each do |type|
      @user_stats[:win][type.title] = @user.stakes
        .win.where(stake_type: type)
        .reduce(0) do |sum, stake|
          sum += stake.bid.to_f
        end
      @user_stats[:lose][type.title] = @user.stakes
        .lose.where(stake_type: type)
        .reduce(0) do |sum, stake|
          sum += stake.bid.to_f
        end
      @user_stats[:sum][type.title] = @user_stats[:win][type.title] - @user_stats[:lose][type.title]
    end
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
