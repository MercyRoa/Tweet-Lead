
class Account < ActiveRecord::Base
	validates_presence_of :username
	validates_uniqueness_of :username
	
	validate :valid_tokens
	 
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
