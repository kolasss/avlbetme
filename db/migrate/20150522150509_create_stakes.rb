class CreateStakes < ActiveRecord::Migration
  def change
    create_table :stakes do |t|
      t.text :objective
      t.text :bid, null: false, default: 0
      t.belongs_to :stake_type, index: true
      t.belongs_to :user, index: true
      t.belongs_to :bet, index: true
      t.boolean :winner, default: false
      t.boolean :paid, default: false

      t.timestamps null: false
    end
  end
end
