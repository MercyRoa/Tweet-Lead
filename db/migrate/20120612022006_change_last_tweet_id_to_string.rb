class ChangeLastTweetIdToString < ActiveRecord::Migration
  def up
    change_column :searches, :last_tweet_id, :string
    change_column :accounts, :last_tweet_id, :string
  end

  def down
    change_column :searches, :last_tweet_id, :integer
    change_column :accounts, :last_tweet_id, :string
  end
end
