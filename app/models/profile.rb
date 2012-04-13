class Profile < ActiveRecord::Base
  has_many :tweets
  belongs_to :account
end
