class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :action_type
      t.integer :threshold
      t.string :data
      t.references :user

      t.timestamps
    end
    add_index :alerts, :user_id
  end
end
