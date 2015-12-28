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
#  created_by   :integer
#  updated_by   :integer
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

  scope :publishable, -> { where(:publish => true).where('publish_time <= ?', Time.zone.now) }

end

