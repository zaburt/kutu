class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  def create
    @picture = Picture.new(picture_params)

    if @picture.save
      redirect_to @picture, notice: t('generic.was_successfully_created', :name => Picture.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /pictures/1
  def update
    if @picture.update(picture_params)
      redirect_to @picture, notice: t('generic.was_successfully_updated', :name => Picture.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /pictures/1
  def destroy
    @picture.destroy
    redirect_to pictures_url, notice: t('generic.was_successfully_destroyed', :name => Picture.model_name.human)
  end

  def new_multi
  end

  def create_multi
    # fail 'multiple_pictures_blank' if params[:multi_pictures].blank?

    multi_picture_params[:images].each do |image|
      Rails.logger.debug image.inspect
      Picture.create(:image => image)
    end

    redirect_to pictures_path
  rescue => e
    # flash[:alert] = e.message == 'multiple_pictures_blank' ? t('multiple_pictures_can_not_be_blank') : e.message
    flash[:alert] = e.message

    redirect_to new_multi_pictures_path
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def picture_params
    params.require(:picture).permit(:name, :game_id, :image, :caption)
  end

  def multi_picture_params
    params.require(:multi_pictures)
  end
end

