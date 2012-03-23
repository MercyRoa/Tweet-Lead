class CreateSheduledMessages < ActiveRecord::Migration
  def change
    create_table :sheduled_messages do |t|
      t.integer :account_id
      t.string :text
      t.datetime :created
      t.datetime :sheduled

      t.timestamps
    end
  end
end
