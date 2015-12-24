class CreateGameCategories < ActiveRecord::Migration
  def change
    create_table :game_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
