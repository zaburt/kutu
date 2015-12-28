# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  name               :string
#  game_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  caption            :string
#
# Indexes
#
#  index_pictures_on_game_id  (game_id)
#

require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
