class BetsController < ApplicationController
  before_action :set_bet, except: [ :new, :create ]
  before_action :require_login, except: [:show]

  def show
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
      flash[:info] = t('messages.updated')
      redirect_to @bet
    else
      render :edit, alert: t('messages.cant_update')
    end
  end

  def destroy
    @bet.destroy
    redirect_to root_path, notice: t('messages.deleted')
  end

  # для выбора выйгравшего
  def stop
  end

  def finish
    if @bet.finish! win_ids, pass_ids
      redirect_to @bet, notice: t('bet.messages.finished')
    else
      redirect_to stop_bet_path(@bet),
        alert: @bet.errors.messages[:finish].join(', ')
    end
  end

  def cancel
    @bet.cancel!
    redirect_to @bet, notice: t('bet.messages.canceled')
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

    def win_ids
      params[:results][:winners].reject(&:blank?)
    end

    def pass_ids
      params[:results][:pass].reject(&:blank?)
    end

end
