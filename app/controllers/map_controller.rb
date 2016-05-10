class MapController < ApplicationController

  def index
    @fullwidth = true
    @focus_on = params[:focus_on]
    @games = Game.all
    @game_hash = {}
  end

end

