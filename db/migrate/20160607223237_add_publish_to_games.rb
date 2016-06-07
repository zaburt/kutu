class AddPublishToGames < ActiveRecord::Migration
  def change
    add_column :games, :publish, :bool, :default => false
  end
end
