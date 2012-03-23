class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :profile_id
      t.integer :status_id
      t.string :status_id_str
      t.string :coordinates
      t.datetime :created_at
      t.string :in_reply_to_screen_name
      t.integer :in_reply_to_status_id
      t.string :in_reply_to_status_id_str
      t.integer :in_reply_to_user_id
      t.string :in_reply_to_user_id_str
      t.integer :retweet_count
      t.boolean :retweeted
      t.string :source
      t.string :text

      t.timestamps
    end
  end
end
