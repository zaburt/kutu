class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :address
      t.references :city, index: true, foreign_key: true
      t.references :game_category, index: true, foreign_key: true
      t.references :house, index: true, foreign_key: true
      t.string :phone
      t.string :email
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.float :lat
      t.float :lng
      t.text :story
      t.text :game_times

      t.timestamps null: false
    end
  end
end
