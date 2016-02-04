class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.boolean :publish
      t.datetime :publish_time
      t.references :game, index: true, foreign_key: true
      t.references :picture, index: true, foreign_key: true
      t.text :content
      t.integer :created_by_id, index: true
      t.integer :updated_by_id, index: true

      t.timestamps null: false
    end
  end
end
