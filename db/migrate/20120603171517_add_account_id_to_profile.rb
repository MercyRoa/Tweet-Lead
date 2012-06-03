class AddAccountIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :account_id, :integer
  end
end
