class AddTokenSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :TokenSecret, :string
  end
end
