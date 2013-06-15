class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :action_type
      t.integer :threshold
      t.string :data
      t.references :user

      t.timestamps
    end
    add_index :actions, :user_id
  end
end
