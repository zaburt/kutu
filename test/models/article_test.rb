# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  title         :string
#  publish       :boolean
#  publish_time  :datetime
#  game_id       :integer
#  picture_id    :integer
#  content       :text
#  created_by_id :integer
#  updated_by_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  frontpage     :boolean          default(TRUE)
#
# Indexes
#
#  index_articles_on_created_by_id  (created_by_id)
#  index_articles_on_game_id        (game_id)
#  index_articles_on_picture_id     (picture_id)
#  index_articles_on_updated_by_id  (updated_by_id)
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
