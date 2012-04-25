class AddLastOwnTweetIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :last_own_tweet_id, :integer
  end
end
