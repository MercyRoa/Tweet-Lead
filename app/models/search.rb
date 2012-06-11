class Search < ActiveRecord::Base
  #que haga las busqueda
  
  def process
         
      a = Account.oldest_used
      
      tweets = Array.new
      config = {:rpp => 100, :page => 1, :result_type => "recent" }
      config[:since_id] = self.last_tweet_id unless self.last_tweet_id.nil?  
    
      while true
        r = a.tc.search(self.search + " -rt -http -#ff", config)
        if r.empty? || config[:page] == 15 then break end
        tweets += r 
        config[:page] += 1 
      end
      
      #raise tweets.map{|t| "@" + t.from_user + ": " + t.text}.to_yaml 
    
      # Por cada tweet
      tweets.each do |t|
        data = {:account_id => a.id, :username => t.from_user, :tweet => t.text}
        #Opps!! Nos falta ponerle reply...!!  
        SearchesResult.create data
        
        self.last_tweet_id = t.id
     
      end
      
      self.save
  end
  
end
