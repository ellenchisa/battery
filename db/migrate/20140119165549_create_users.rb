class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :facebookid
      t.string :phone
      t.string :name
      t.integer :notification_hour
      t.timestamps
    end
  end
end
