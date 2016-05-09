class MapController < ApplicationController

  def index
    @fullwidth = true
    games_for_map
  end


  private


  def games_for_map
    @games = Game.all
    @game_hash = {}

    @games.each do |game|
      next unless game.lat && game.lng
      @game_hash[game.slug] = game.attributes
    end
  end

end

