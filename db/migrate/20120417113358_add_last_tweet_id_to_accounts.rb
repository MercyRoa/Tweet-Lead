class AddLastTweetIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :last_tweet_id, :integer
  end
end
