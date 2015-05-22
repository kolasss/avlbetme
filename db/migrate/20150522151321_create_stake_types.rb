class CreateStakeTypes < ActiveRecord::Migration
  def change
    create_table :stake_types do |t|
      t.string :title, null: false
      t.boolean :numeric, default: false

      t.timestamps null: false
    end
  end
end
