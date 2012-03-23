class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :password
      t.string :description
      t.string :group
      t.string :token
      t.string :token_secret
      t.integer :mentions_count
      t.integer :new_mentions_count

      t.timestamps
    end
  end
end
