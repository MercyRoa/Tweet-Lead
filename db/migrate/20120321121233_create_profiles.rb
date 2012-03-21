class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :screen_name
      t.datetime :created_at
      t.integer :followers_count
      t.integer :friends_count
      t.integer :twitter_id
      t.string :lang
      t.location :location
      t.string :profile_image_url
      t.boolean :protected
      t.string :time_zone
      t.text :description
      t.string :url
      t.integer :utc_offset

      t.timestamps
    end
  end
end
