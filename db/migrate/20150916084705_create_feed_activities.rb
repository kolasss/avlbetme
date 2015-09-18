class CreateFeedActivities < ActiveRecord::Migration
  def change
    create_table :feed_activities do |t|
      t.references :user, index: true, foreign_key: true
      t.references :bet, index: true, foreign_key: true
      t.references :stake, index: true, foreign_key: true
      t.string :type
      t.jsonb :details, null: false, default: {}

      t.datetime "created_at", null: false
    end
  end
end
