# == Schema Information
#
# Table name: article_categories_articles
#
#  article_id          :integer
#  article_category_id :integer
#
# Indexes
#
#  index_article_categories_articles_on_article_category_id  (article_category_id)
#  index_article_categories_articles_on_article_id           (article_id)
#

class ArticleCategoriesArticle < ActiveRecord::Base
  belongs_to :article_category
  belongs_to :article

end

