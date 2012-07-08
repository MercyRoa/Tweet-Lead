class ChangeTwittersIdToString < ActiveRecord::Migration
  def up
  	change_column :tweets, :status_id, :string
  	change_column :tweets, :in_reply_to_status_id, :string
  	change_column :tweets, :in_reply_to_user_id, :string
  	change_column :profiles, :twitter_id, :string
  	change_column :accounts, :last_own_tweet_id, :string
  end

  def down
  	change_column :tweets, :status_id, :integer
  	change_column :tweets, :in_reply_to_status_id, :integer
  	change_column :tweets, :in_reply_to_user_id, :integer
  	change_column :profiles, :twitter_id, :integer
  	change_column :accounts, :last_own_tweet_id, :integer
  end
end