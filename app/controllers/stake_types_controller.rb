class StakeTypesController < ApplicationController
  before_action :set_stake_type, except: [ :index, :new, :create ]

  def index
    @stake_types = StakeType.all
    authorize @stake_types
  end

  def new
    @stake_type = StakeType.new
    authorize @stake_type
  end

  def create
    @stake_type = StakeType.new(stake_type_params)
    authorize @stake_type
    if @stake_type.save
      flash[:info] = t('messages.created')
      redirect_to stake_types_path
    else
      render 'new', alert: t('messages.cant_create')
    end
  end

  def edit
  end

  def update
    if @stake_type.update_attributes(stake_type_params)
      flash[:info] = t('messages.updated')
      redirect_to stake_types_path
    else
      render :edit, alert: t('messages.cant_update')
    end
  end

  def destroy
    if @stake_type.destroy
      flash[:notice] = t('messages.deleted')
    else
      flash[:alert] = t('messages.cant_delete')
    end
    redirect_to stake_types_path
  end

  private

    def set_stake_type
      @stake_type = StakeType.find(params[:id])
      authorize @stake_type
    end

    def stake_type_params
      params.require(:stake_type).permit(
        :title,
        :numeric
      )
    end
end
