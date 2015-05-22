class BetsController < ApplicationController
  before_action :set_bet, except: [ :new, :create ]

  def show
  end

  def new
    @bet = Bet.new
  end

  def create
    @bet = User.new(bet_params)
    if @bet.save
      flash[:info] = "Пари создано."
      redirect_to @bet
    else
      render 'new', alert: t(:create_failed)
    end
  end

  def edit
  end

  def update
    if @bet.update_attributes(bet_params)
      redirect_to @bet
    else
      render :edit, alert: t(:update_failed)
    end
  end

  def destroy
    @bet.destroy
    redirect_to root_path
  end

  private
    def set_bet
      @bet = Bet.find(params[:id])
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
