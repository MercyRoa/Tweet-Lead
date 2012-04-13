class AddAccountIdAndSheduledAndSentAndFromAccountToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :account_id, :integer
    add_column :tweets, :sheduled, :datetime
    add_column :tweets, :sent, :bool
    add_column :tweets, :from_account, :bool
  end
end
