class AddSentToSearchesResults < ActiveRecord::Migration
  def change
    add_column :searches_results, :sent, :boolean
  end
end
