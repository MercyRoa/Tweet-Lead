class DropSearches < ActiveRecord::Migration
  def up
    drop_table :searches
    create_table :searches do |t|
      t.string :search
      t.string :responses

      t.timestamps
    end
  end

  def down
   
  end
end
