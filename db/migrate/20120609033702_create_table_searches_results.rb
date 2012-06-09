class CreateTableSearchesResults < ActiveRecord::Migration
 def change
    create_table :searches_results do |t|
      t.integer :account_id
      t.string :username
      t.string :tweet
      t.string :reply

      t.timestamps
    end
  end
end

  
