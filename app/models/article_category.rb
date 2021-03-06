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
  has_many :article_categories_articles
  has_many :articles, -> {order(:position)}, :through => :article_categories_articles

end

