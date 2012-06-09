class AddLastTweetIdToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :last_tweet_id, :integer
  end
end
