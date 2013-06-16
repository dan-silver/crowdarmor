class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :Token, :string
  end
end
