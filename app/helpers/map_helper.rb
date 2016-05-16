module MapHelper

  EXCLUDED_ATTRIBUTES_GAME = [
    'story',
    'game_times',
    'created_at',
    'updated_at'
  ]

  def prepare_games_for_map
    data = []

    @games.each do |game|
      next unless game.lat && game.lng

      props = {
        :title => title_for_game(game),
        :description => game.game_category.name,
        :game_link => link_to(title_for_game(game), game, :title => t('show')),
        :city => game.city.name,
        :game_category => game.game_category.name,
        :house => game.house.name
      }.merge(game.attributes.except(EXCLUDED_ATTRIBUTES_GAME))

      game_data = {
        :type => 'Feature',
        :geometry => {
          :type => 'Point',
          :coordinates => [game.lng, game.lat]
        },
        :properties => props
      }

      data << game_data
    end

    data
  end

  def city_map
    [
      [t('all'), nil]
    ] + City.order(:name).map do |k|
      [k.name, k.id]
    end
  end

  def game_category_map
    [
      [t('all'), nil]
    ] + GameCategory.order(:name).map do |k|
      [k.name, k.id]
    end
  end

  def active_map
    [
      [t('all'), nil],
      [fonticon('check', 'green'), true],
      [fonticon('x', 'red'), false]
    ]
  end
end

