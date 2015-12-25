class Game < ActiveRecord::Base
  belongs_to :city
  belongs_to :game_category
  belongs_to :house
end
