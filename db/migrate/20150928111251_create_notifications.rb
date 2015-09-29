class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true
      t.belongs_to :activity, index: true

      t.datetime "created_at", null: false
    end
  end
end
