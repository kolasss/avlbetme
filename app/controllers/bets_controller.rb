class BetsController < ApplicationController
  before_action :set_bet, except: [ :new, :create ]
  before_action :require_login, except: [:show]

  def show
    @stakes = @bet.stakes.includes :user, :stake_type
  end

  def new
    @bet = Bet.new
    authorize @bet
  end

  def create
    Bet.transaction do
      @bet = Bet.new(bet_params)
      authorize @bet
      if @bet.save
        @bet.create_default_stake_for_user current_user.id
        @bet.log_creation current_user
        flash[:info] = t('messages.created')
        redirect_to @bet
      else
        render 'new', alert: t('messages.cant_create')
      end
    end
  end

  def edit
  end

  def update
    if @bet.update_attributes(bet_params)
      # debugger
      @bet.log_update current_user
      flash[:info] = t('messages.updated')
      redirect_to @bet
    else
      render :edit, alert: t('messages.cant_update')
    end
  end

  def destroy
    @bet.destroy
    @bet.log_deletion current_user
    redirect_to root_path, notice: t('messages.deleted')
  end

  # для выбора выйгравшего
  def stop
    # флаг для отображения контролов в views/bets/_bet_stake.html.slim
    @stop = true
    @stakes = @bet.stakes
  end

  def finish
    if @bet.finish! params[:results]
      @bet.log_update current_user
      redirect_to @bet, notice: t('bet.messages.finished')
    else
      redirect_to stop_bet_path(@bet),
        alert: @bet.errors.messages[:finish].join(', ')
    end
  end

  def cancel
    if @bet.cancel!
      @bet.log_update current_user
    end
    redirect_to @bet, notice: t('bet.messages.canceled')
  end

  def activities
    @activities = @bet.activities.includes :user
    render layout: false
  end

  private

    def set_bet
      @bet = Bet.find(params[:id])
      authorize @bet
    end

    def bet_params
      params.require(:bet).permit(
        :title,
        :body,
        :started_at,
        :stopped_at
      )
    end
end
