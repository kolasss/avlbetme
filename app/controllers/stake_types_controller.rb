class StakeTypesController < ApplicationController
  before_action :set_stake_type, except: [ :index, :new, :create ]

  def index
    @stake_types = StakeType.all
  end

  def new
    @stake_type = StakeType.new
  end

  def create
    @stake_type = StakeType.new(stake_type_params)
    if @stake_type.save
      flash[:info] = "Тип ставки создан."
      redirect_to stake_types_path
    else
      render 'new', alert: t(:create_failed)
    end
  end

  def edit
  end

  def update
    if @stake_type.update_attributes(stake_type_params)
      flash[:info] = "Тип ставки обновлен."
      redirect_to stake_types_path
    else
      render :edit, alert: t(:update_failed)
    end
  end

  def destroy
    if @stake_type.destroy
      flash[:notice] = "Тип ставки удален."
    else
      flash[:alert] = "Error deleting"
    end
    redirect_to stake_types_path
  end

  private
    def set_stake_type
      @stake_type = StakeType.find(params[:id])
    end

    def stake_type_params
      params.require(:stake_type).permit(
        :title,
        :numeric
      )
    end
end
