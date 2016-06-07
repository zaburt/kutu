# == Schema Information
#
# Table name: game_labels_games
#
#  id            :integer          not null, primary key
#  game_id       :integer
#  game_label_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_game_labels_games_on_game_id        (game_id)
#  index_game_labels_games_on_game_label_id  (game_label_id)
#

require 'test_helper'

class GameLabelsGameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
