class CreateGameLabels < ActiveRecord::Migration
  def change
    create_table :game_labels do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
