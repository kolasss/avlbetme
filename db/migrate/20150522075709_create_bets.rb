class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :title, null: false
      t.text :body
      t.datetime :start_dt
      t.datetime :stop_dt
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
