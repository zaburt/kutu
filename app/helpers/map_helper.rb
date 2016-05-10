module MapHelper

  def prepare_games_for_map
    @games.each do |game|
      next unless game.lat && game.lng
      @game_hash[game.slug] = game.attributes.merge(:game_link => link_to(fonticon('eye'), game, :title => t('show')))
    end

    @game_hash
  end

end

