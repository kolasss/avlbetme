class AddFriendsToUsers < ActiveRecord::Migration
  def change
    # enable_extension 'citext'
    add_column :users, :friends, :jsonb, null: false, default: {}
    add_index  :users, :friends, using: :gin
  end
end
