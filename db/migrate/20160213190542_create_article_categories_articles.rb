class CreateArticleCategoriesArticles < ActiveRecord::Migration
  def change
    create_table :article_categories_articles, :id => false do |t|
      t.belongs_to :article, :index => true
      t.belongs_to :article_category, :index => true
    end
  end
end

