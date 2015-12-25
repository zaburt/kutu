# == Schema Information
#
# Table name: games
#
#  id               :integer          not null, primary key
#  name             :string
#  address          :text
#  city_id          :integer
#  game_category_id :integer
#  house_id         :integer
#  phone            :string
#  email            :string
#  website          :string
#  facebook         :string
#  twitter          :string
#  instagram        :string
#  lat              :float
#  lng              :float
#  story            :text
#  game_times       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_games_on_city_id           (city_id)
#  index_games_on_game_category_id  (game_category_id)
#  index_games_on_house_id          (house_id)
#

require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
