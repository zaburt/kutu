module MapHelper

  def prepare_games_for_map
    @games.each do |game|
      next unless game.lat && game.lng
      @game_hash[game.slug] = game.attributes.merge(
        :game_link => link_to(title_for_game(game), game, :title => t('show')),
        :city => game.city.name
      )
    end

    @game_hash
  end

end

