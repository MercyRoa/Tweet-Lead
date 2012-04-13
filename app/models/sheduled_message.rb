class SheduledMessage < ActiveRecord::Base
  belongs_to :account
  belongs_to :profile

end
