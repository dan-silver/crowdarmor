class AddTwitterHandleToUser < ActiveRecord::Migration
  def change
    add_column :users, :Twitter_Handle, :string
  end
end
