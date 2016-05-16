class MapController < ApplicationController

  def index
    @fullwidth = true
    @focus_on = params[:focus_on]
    @games = Game.includes(:game_category, :city)
    @city_hash = Hash[City.order(:name).map{|k| [k.name, k.id]}]
    @game_category_hash = Hash[GameCategory.order(:name).map{|k| [k.name, k.id]}]
    @game_hash = {}
  end

end

