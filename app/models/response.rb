class Response < ActiveRecord::Base
  has_and_belongs_to_many :keywords

  validates_presence_of :alias, :text
end
