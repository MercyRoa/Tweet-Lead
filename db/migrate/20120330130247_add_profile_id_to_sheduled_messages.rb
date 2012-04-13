class AddProfileIdToSheduledMessages < ActiveRecord::Migration
  def change
    add_column :sheduled_messages, :profile_id, :integer
  end
end
