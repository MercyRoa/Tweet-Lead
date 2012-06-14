class AddTweetedAtToSearchesResults < ActiveRecord::Migration
  def change
    add_column :searches_results, :tweeted_at, :datetime
  end
end
