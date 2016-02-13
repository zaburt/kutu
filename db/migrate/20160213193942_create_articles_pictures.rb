class CreateArticlesPictures < ActiveRecord::Migration
  def change
    create_table :articles_pictures, :id => false do |t|
      t.belongs_to :article, :index => true
      t.belongs_to :picture, :index => true
    end
  end
end

