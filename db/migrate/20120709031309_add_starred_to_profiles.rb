class AddStarredToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :starred, :bool
  end
end
