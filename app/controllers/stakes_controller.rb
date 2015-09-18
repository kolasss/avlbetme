class StakesController < ApplicationController
  before_action :set_stake, except: [ :new, :create ]
  before_action :set_bet

  def new
    @stake = @bet.stakes.new
    load_friends
  end

  def create
    @stake = @bet.stakes.new(stake_params)
    if @stake.save
      @stake.log_creation current_user
      flash[:info] = t('messages.created')
      redirect_to @bet
    else
      load_friends
      render 'new', alert: t('messages.cant_create')
    end
  end

  def edit
    load_friends
  end

  def update
    if @stake.update_attributes(stake_params)
      @stake.log_update current_user
      flash[:info] = t('messages.updated')
      redirect_to @bet
    else
      load_friends
      render :edit, alert: t('messages.cant_update')
    end
  end

  def destroy
    # validate that stake not single in current bet
    if @stake.not_last? && @stake.destroy
      @stake.log_deletion current_user
      flash[:notice] = t('messages.deleted')
    else
      flash[:alert] = t('messages.cant_delete')
    end
    redirect_to @bet
  end

  private

    def set_stake
      @stake = Stake.find(params[:id])
    end

    def set_bet
      @bet = Bet.find(params[:bet_id])
      authorize @bet, :edit?
    end

    def stake_params
      params.require(:stake).permit(
        :objective,
        :bid,
        :user_id,
        :stake_type_id
      )
    end

    def load_friends
      @friends = current_user.friends_list_with_self
    end
end
