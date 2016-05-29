class CreateGameLabelsGames < ActiveRecord::Migration
  def change
    create_table :game_labels_games do |t|
      t.references :game, index: true, foreign_key: true
      t.references :game_label, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
