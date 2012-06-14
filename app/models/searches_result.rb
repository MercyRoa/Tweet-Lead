class SearchesResult < ActiveRecord::Base
  scope :to_sent, where(:sent => nil)
end
