
class Search < ActiveRecord::Base
  MAX_RESULTS_PER_REQUEST = 1000

  #que haga las busquedas
  def process 
     
    #a = Account.oldest_used
    accounts = Account.order(:updated_at).all
    a = accounts.first

    tweets, data, self.temp_usernames = [],[],[]
    
    config = {:count => 100, :result_type => "recent" }
    config[:since_id] = self.last_tweet_id.to_i unless self.last_tweet_id.nil?  
    
    while true
      r = a.tc.search(self.search + " -rt -http -#ff", config)
      config[:max_id] = r.results.last.id - 1
      tweets += r.results
      puts "Found... #{tweets.count} tweets in total"
      break if r.results.empty? || tweets.count > MAX_RESULTS_PER_REQUEST
    end
    
    # raise tweets.map{|t| "@" + t.from_user + ": " + t.text }.to_yaml 
    if !tweets.empty? 

      replies = File.readlines "vendor/replies/" + self.responses

      tweets.reject { |t| self.repeat_user(t.from_user) }.each_with_index do |t,i|
        puts "#{i}. Tweet de @" + t.from_user
        reply = "@#{t.from_user} " +  replies[rand(replies.count)]

        #check encoding and length

        #apply filters

        data << SearchesResult.new({
            :account_id => accounts.sample.id, 
            :username => t.from_user, 
            :tweet => t.text, 
            :reply => reply,
            :tweeted_at => t.created_at
        })
      end

      self.last_tweet_id = tweets.first.id
      self.save

      if !data.empty?
        SearchesResult.import data.reverse
      end
    end
    
    self.save_log tweets.count, data.count, 1
    
    
    data.map{|t| "@" + t.username + ": " + t.tweet}.to_yaml
  end
  
  # Ckeck that is not a repetead user, should be called with reject
  # user is string
  # usernames is array
  attr_accessor :temp_usernames
  def repeat_user(user)
    to_return = ( 
          self.temp_usernames.include?(user)        ||
          Profile.exists?(:screen_name => user)     ||
          SearchesResult.exists?(:username => user) 
    )
    self.temp_usernames << user
    to_return
  end
  
  
  def save_log results, saved, page
    SearchesLog.create({
        :search_id => self.id, 
        :results => results, 
        :saved => saved,
        :page => page
      })
  end
  
end
