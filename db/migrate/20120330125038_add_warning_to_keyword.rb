class AddWarningToKeyword < ActiveRecord::Migration
  def change
    add_column :keywords, :warning, :bool
  end
end
