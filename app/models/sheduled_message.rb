class SheduledMessage < ActiveRecord::Base
  belongs_to :account
  belongs_to :profile
  
  def self.send_all
    sms = self.all
    
    sms.each do |sm| 
      sm.send_msg
    end
  end
  
  def send_msg
      puts " * Enviando: "+self.text
      
      data = Tweet.convert_from_status(self.account.tc.update self.text)
      data['account_id'] = self.account_id
      data['profile_id'] = self.profile_id
      data['from_account'] = true
      data['sent'] = true

      if Tweet.new(data).save
        self.delete
      else  
        raise "Error guardando tweet"+self.text
      end
  end
end
