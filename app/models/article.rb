# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  title        :string
#  publish      :boolean
#  publish_time :datetime
#  game_id      :integer
#  picture_id   :integer
#  content      :text
#  created_by_id   :integer
#  updated_by_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_articles_on_game_id     (game_id)
#  index_articles_on_picture_id  (picture_id)
#

class Article < ActiveRecord::Base
  belongs_to :game
  belongs_to :picture
  belongs_to :created_by, :foreign_key => 'created_by_id', :class_name => 'User'
  belongs_to :updated_by, :foreign_key => 'updated_by_id', :class_name => 'User'

  scope :publishable, -> { where(:publish => true).where('publish_time <= ?', Time.zone.now) }

  scope :for_game, -> (game) {
    if game.is_a?(Game)
      where(:game_id => game.id)
    else
      where(:game_id => game)
    end
  }

end

