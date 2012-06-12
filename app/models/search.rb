class Search < ActiveRecord::Base
  #que haga las busqueda
  
  def process 
     
    #a = Account.oldest_used
    accounts = Account.order(:updated_at).all
    a = accounts.first

    tweets, data, usernames = [],[],[]
    
    config = {:rpp => 5, :page => 1, :result_type => "recent" }
    config[:since_id] = self.last_tweet_id unless self.last_tweet_id.nil?  
    
    while true
      puts "pagina " + config[:page].to_s
        
      r = a.tc.search(self.search + " -rt -http -#ff", config)
      if r.empty? || config[:page] == 2 then break end
      tweets += r 
      config[:page] += 1 
    end
    #raise tweets.map{|t| "@" + t.from_user + ": " + t.text}.to_yaml 
    if tweets.empty? then return 
      
    end
    
    replies = File.readlines "vendor/replies/replies.txt" 
    
    tweets.reject { |t| self.repeat_user(t.from_user, usernames) }.each_with_index do |t,i|
      puts "#{i}. Tweet de @" + t.from_user
      reply = "@#{t.from_user} " +  replies[rand(replies.count)]
      
      #check encoding and length
      
      #aply filters
      
      usernames << t.from_user
      data << SearchesResult.new({
          :account_id => accounts[rand(accounts.count)], 
          :username => t.from_user, 
          :tweet => t.text, 
          :reply => reply 
      })
    
      self.last_tweet_id = t.id
    end
    
    return if !data.empty?
    
    raise data.map{|t| "@" + t.username + ": " + t.tweet}.to_yaml 
  end
  
  #Ckeck that is not a repetead user, should be called with reject
  # user is string
  # usernames is array
  def repeat_user(user, usernames)
    Profile.exists?(:screen_name => user)    ||
    SearchesResult.exists?(:username => user) ||
    usernames.include?(user)
  end

  
end
