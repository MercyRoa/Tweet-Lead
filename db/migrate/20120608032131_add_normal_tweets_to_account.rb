class AddNormalTweetsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :normal_tweets, :text
  end
end
