class GameLabelsController < ApplicationController
  before_action :set_game_label, only: [:show, :edit, :update, :destroy]

  # GET /game_labels
  def index
    @game_labels = GameLabel.all
  end

  # GET /game_labels/1
  def show
  end

  # GET /game_labels/new
  def new
    @game_label = GameLabel.new
  end

  # GET /game_labels/1/edit
  def edit
  end

  # POST /game_labels
  def create
    @game_label = GameLabel.new(game_label_params)

    if @game_label.save
      redirect_to @game_label, notice: 'Game label was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /game_labels/1
  def update
    if @game_label.update(game_label_params)
      redirect_to @game_label, notice: 'Game label was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /game_labels/1
  def destroy
    @game_label.destroy
    redirect_to game_labels_url, notice: 'Game label was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_label
      @game_label = GameLabel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_label_params
      params.require(:game_label).permit(:name, :description)
    end
end
