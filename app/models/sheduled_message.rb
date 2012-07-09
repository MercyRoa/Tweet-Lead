class SheduledMessage < ActiveRecord::Base
  belongs_to :account
  belongs_to :profile

  validates :text, :presence => true

  after_save do |sm|
    if !sm.profile_id.nil? then
      p = Profile.find(sm.profile_id)
      p.waiting_reply = true
      p.save
    end
  end
  
  def self.send_all
    sms = self.all
    
    sms.each do |sm| 
      sm.send_msg
    end
  end
  
  def send_msg
      puts " * Enviando: "+self.text

      self.text = "@#{self.profile.screen_name} #{self.text}" unless self.text =~ /@#{self.profile.screen_name}/
      
      data = Tweet.convert_from_status(self.account.tc.update self.text)
      data['account_id'] = self.account_id
      data['profile_id'] = self.profile_id
      data['from_account'] = true
      data['sent'] = true

      if Tweet.new(data).save
        self.delete
      else  
        raise "Error guardando tweet "+self.text
      end
  end
end
