class AddWaitingReplyToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :waiting_reply, :bool, :default => false
  end
end
