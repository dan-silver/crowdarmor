class ColName < ActiveRecord::Migration
  def up
  	 rename_column :users, :Twitter_Handle, :twitter_handl
  end

  def down
  	 rename_column :users, :twitter_handl, :Twitter_Handle
  end
end
