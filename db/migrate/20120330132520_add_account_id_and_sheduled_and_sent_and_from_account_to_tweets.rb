class AddAccountIdAndSheduledAndSentAndFromAccountToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :account_id, :integer
    add_column :tweets, :sheduled, :datetime
    add_column :tweets, :sent, :boolean
    add_column :tweets, :from_account, :boolean
  end
end
