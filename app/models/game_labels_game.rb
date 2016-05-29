class GameLabelsGame < ActiveRecord::Base
  belongs_to :game
  belongs_to :game_label
end
