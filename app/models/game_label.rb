# == Schema Information
#
# Table name: game_labels
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GameLabel < ActiveRecord::Base
end
