class CreateSearchesLogs < ActiveRecord::Migration
  def change
    create_table :searches_logs do |t|
      t.integer :search_id
      t.integer :results
      t.integer :saved
      t.integer :page

      t.timestamps
    end
  end
end
