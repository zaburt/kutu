# == Schema Information
#
# Table name: game_comments
#
#  id         :integer          not null, primary key
#  comment    :text
#  game_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_game_comments_on_game_id  (game_id)
#  index_game_comments_on_user_id  (user_id)
#

require 'test_helper'

class GameCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
