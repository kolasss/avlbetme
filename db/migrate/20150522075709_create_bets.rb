class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :title, null: false
      t.text :body
      t.datetime :started_at
      t.datetime :stopped_at
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
