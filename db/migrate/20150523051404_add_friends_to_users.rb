class AddFriendsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friends, :jsonb, null: false, default: {}
    add_index  :users, :friends, using: :gin
  end
end
