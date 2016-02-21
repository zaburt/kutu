class GameCommentsController < ApplicationController
  before_action :set_game_comment, only: [:show, :edit, :update, :destroy]

  # GET /game_comments
  def index
    @game_comments = GameComment.all
  end

  # GET /game_comments/1
  def show
  end

  # GET /game_comments/new
  def new
    @game_comment = GameComment.new(new_game_comment_params.merge(:user_id => current_user.id))
  end

  # GET /game_comments/1/edit
  def edit
  end

  # POST /game_comments
  def create
    @game_comment = GameComment.new(game_comment_params)

    if @game_comment.save
      redirect_to @game_comment, notice: t('generic.was_successfully_created', :name => GameComment.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /game_comments/1
  def update
    if @game_comment.update(game_comment_params)
      redirect_to @game_comment, notice: t('generic.was_successfully_updated', :name => GameComment.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /game_comments/1
  def destroy
    @game_comment.destroy
    redirect_to game_comments_url, notice: t('generic.was_successfully_destroyed', :name => GameComment.model_name.human)
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_game_comment
    @game_comment = GameComment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_comment_params
    params.require(:game_comment).permit(:comment, :game_id, :user_id)
  end

  def new_game_comment_params
    params.permit(:comment, :game_id)
  end

end

