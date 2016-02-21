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
#  slug             :string
#
# Indexes
#
#  index_games_on_city_id           (city_id)
#  index_games_on_game_category_id  (game_category_id)
#  index_games_on_house_id          (house_id)
#  index_games_on_slug              (slug) UNIQUE
#

class Game < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :city
  belongs_to :game_category
  belongs_to :house

  validates_presence_of :name

  scope :active, -> {where(:active => true)}
  scope :for_house, -> (house) {
    if house.is_a?(House)
      where(:house_id => house.id)
    else
      where(:house_id => house)
    end
  }

end

