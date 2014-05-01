class AddDeletedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :deleted, :boolean
  end
end
