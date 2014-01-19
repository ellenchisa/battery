class CreateBatteries < ActiveRecord::Migration
  def change
    create_table :batteries do |t|
      t.integer :user_id
      t.integer :level
      t.timestamps
    end
  end
end
