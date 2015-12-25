# == Schema Information
#
# Table name: article_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleCategory < ActiveRecord::Base
end
