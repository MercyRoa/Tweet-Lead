class SearchesResult < ActiveRecord::Base
  scope :to_sent, where(:sent => nil)
  belongs_to :account

  def tweet_it_test
    puts "TEST-#{account.username}: #{id} #{reply}"
  end

  def tweet_it
    return begin
      puts "#{account.username}: #{id} #{reply}"
      account.tc.update reply
      if id
        self.sent = true
        self.save
      end
    rescue Exception => e  
      puts e.message  
      puts e.backtrace.inspect.to_yaml  
    end
  end
end
