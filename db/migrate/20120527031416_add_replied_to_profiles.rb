class AddRepliedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :replied, :boolean
  end
end
