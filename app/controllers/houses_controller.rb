class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  # GET /houses
  def index
    @houses = House.all
  end

  # GET /houses/1
  def show
    @games = Game.for_house(@house).include_unpublished(signed_in?)
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  def create
    @house = House.new(house_params)

    if @house.save
      redirect_to @house, notice: t('generic.was_successfully_created', :name => House.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /houses/1
  def update
    if @house.update(house_params)
      redirect_to @house, notice: t('generic.was_successfully_updated', :name => House.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /houses/1
  def destroy
    @house.destroy
    redirect_to houses_url, notice: t('generic.was_successfully_destroyed', :name => House.model_name.human)
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_house
    @house = House.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def house_params
    params.require(:house).permit(:name)
  end

end

