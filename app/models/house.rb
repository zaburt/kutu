# == Schema Information
#
# Table name: houses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class House < ActiveRecord::Base
end
