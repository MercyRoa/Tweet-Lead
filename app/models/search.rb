class Search < ActiveRecord::Base
  #que haga las busqueda
  
  def process 
        
    a = Account.oldest_used

    tweets = Array.new
    config = {:rpp => 100, :page => 1, :result_type => "recent" }
    config[:since_id] = self.last_tweet_id unless self.last_tweet_id.nil?  

    
    while true
      puts "pagina " + config[:page].to_s
        
      r = a.tc.search(self.search + " -rt -http -#ff", config)
      if r.empty? || config[:page] == 15 then break end
      tweets += r 
      config[:page] += 1 
    end
    #raise tweets.map{|t| "@" + t.from_user + ": " + t.text}.to_yaml 
    if tweets.empty? then return 
      
    end
    
    replies = File.readlines "vendor/replies/replies.txt" 
    
    data = []
    # Por cada tweet
    tweets.each_with_index do |t,i|
      puts "#{i}. Tweet de @" + t.from_user
      reply = "@#{t.from_user} " +  replies[rand(replies.count)]
      #VErificar codificacion , rn al final y longitud <140 
      data << SearchesResult.new({:account_id => a.id, :username => t.from_user, :tweet => t.text, :reply => reply })
      #Opps!! Nos falta ponerle reply...!!  
      
      self.last_tweet_id = t.id
    end
    SearchesResult.import data
      
    self.save
    raise tweets.map{|t| "@" + t.from_user + ": " + t.text}.to_yaml 
  end
  
end
