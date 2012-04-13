class AddAliasToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :alias, :string
  end
end
