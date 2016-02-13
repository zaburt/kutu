# == Schema Information
#
# Table name: article_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleCategoriesArticle < ActiveRecord::Base
  belongs_to :article_category
  belongs_to :article

end

