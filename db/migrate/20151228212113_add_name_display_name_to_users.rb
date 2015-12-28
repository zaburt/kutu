class AddNameDisplayNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :display_name, :string
  end
end
