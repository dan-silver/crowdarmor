class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :user
      t.string :tweet_id
      t.text :body
      t.integer :score

      t.timestamps
    end
    add_index :tweets, :user_id
  end
end
