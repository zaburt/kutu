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
      redirect_to @picture, notice: 'Picture was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pictures/1
  def update
    if @picture.update(picture_params)
      redirect_to @picture, notice: 'Picture was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pictures/1
  def destroy
    @picture.destroy
    redirect_to pictures_url, notice: 'Picture was successfully destroyed.'
  end

  def new_multi
  end

  def create_multi
    params.require(:multi_pictures)
    all_processed = true

    fail 'multiple_pictures_blank' if params[:multi_pictures].blank?

    params[:multi_pictures][:images].each do |image|
      Rails.logger.debug image.inspect
      Picture.create(:image => image)
    end

    if all_processed
      redirect_to pictures_path
    else
      render :new_multi
    end
  rescue => e
    case e.message
    when 'multiple_pictures_blank'
      flash[:alert] = t('multiple_pictures_can_not_be_blank')
    else
      flash[:alert] = e.message
    end

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

end

