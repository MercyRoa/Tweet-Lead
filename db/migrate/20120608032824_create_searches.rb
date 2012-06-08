class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.text :search
      t.text :responses

      t.timestamps
    end
  end
end
