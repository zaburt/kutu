# == Schema Information
#
# Table name: game_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GameCategory < ActiveRecord::Base
end
