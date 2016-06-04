class AddRatingToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :rating_puzzle, :integer, :default => 0
    add_column :articles, :rating_fun, :integer, :default => 0
    add_column :articles, :rating_fluency, :integer, :default => 0
    add_column :articles, :rating_ambience, :integer, :default => 0
    add_column :articles, :rating_management, :integer, :default => 0
    add_column :articles, :rating_service, :integer, :default => 0
    add_column :articles, :rating_average, :float, :default => 0.0
  end
end
