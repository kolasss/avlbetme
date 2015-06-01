class StakesController < ApplicationController
  before_action :set_stake, except: [ :new, :create ]
  before_action :set_bet, except: [ :update, :destroy ]

  def new
    @stake = @bet.stakes.new
  end

  def create
    @stake = @bet.stakes.new(stake_params)
    p @stake
    if @stake.save
      flash[:info] = t('messages.created')
      redirect_to @bet
    else
      render 'new', alert: t('messages.cant_create')
    end
  end

  def edit
  end

  def update
    authorize @stake.bet, :edit?
    if @stake.update_attributes(stake_params)
      flash[:info] = t('messages.updated')
      redirect_to @stake.bet
    else
      render :edit, alert: t('messages.cant_update')
    end
  end

  def destroy
    authorize @stake.bet, :edit?
    if @stake.not_last? && @stake.destroy
      flash[:notice] = t('messages.deleted')
    else
      flash[:alert] = t('messages.cant_delete')
    end
    redirect_to @stake.bet
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
end
