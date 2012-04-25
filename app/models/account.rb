
class Account < ActiveRecord::Base
	validates_presence_of :username
	validates_uniqueness_of :username
	
	validate :valid_tokens
  
  has_many :tweets
  
  # Obtain our tweets
  def get_timeline
    config = {:count => 200}
    config[:since_id] = self.last_own_tweet_id unless self.last_own_tweet_id.nil?
    
    tws = self.tc.user_timeline config
    
    # Por cada tweet
    tws.each do |t|
      next if Tweet.exists?({:status_id => t.id})
     
      # Verificamos si ya existe el profile
      p = Profile.get t.in_reply_to_screen_name, self
      
      data = t.to_hash.select{ |k,v| [ 'coordinates', 'created_at',
          'in_reply_to_screen_name', 'in_reply_to_status_id', 
          'in_reply_to_status_id', 'in_reply_to_user_id', 'in_reply_to_user_id_str',
          'retweet_count', 'retweeted', 'source', 'text'
        ].include?(k)
      }
      # seteamos datos extras
      data['account_id'] = a.id
      data['profile_id'] = p.id
      data['status_id'] = t.id
      data['status_id_str'] = t.id
      a.last_tweet_id = t.id
      
      # guardamos el tweet
      t = Tweet.new(data)
      t.save
    end
    a.save
  end

  
  #	 -------- Oauth methods
	def valid_tokens
		if tokens?
			# @ToDo this method return error if credentials arent valid, should return false. fix it
			if !self.tc.verify_credentials
				errors.add(:token, "tokens arent valid")
			end
		end
	end

	# Already have authentication tokens
	def tokens?
		!self.token.empty? && !self.token_secret.empty?
	end

  # holds the twitter client
  attr_accessor :twitter_client

  def tc
    self.twitter_client = Twitter::Client.new(
        :oauth_token => self.token,
        :oauth_token_secret => self.token_secret
    ) if self.twitter_client.nil?
      
    self.twitter_client
  end
  
end
