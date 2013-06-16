class ColName < ActiveRecord::Migration
  def up
  	 rename_column :users, :Twitter_Handle, :twitter_handle
  end

  def down
  	 rename_column :users, :twitter_handle, :Twitter_Handle
  end
end
