class AddFrontpageToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :frontpage, :boolean, :default => true
  end
end
