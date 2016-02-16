# == Schema Information
#
# Table name: articles_pictures
#
#  article_id :integer
#  picture_id :integer
#
# Indexes
#
#  index_articles_pictures_on_article_id  (article_id)
#  index_articles_pictures_on_picture_id  (picture_id)
#

class ArticlesPicture < ActiveRecord::Base
  belongs_to :article
  belongs_to :picture

end

