class Tweet < ActiveRecord::Base
  belongs_to  :profile
  belongs_to  :account
  
  def self.extract_mentions
    # Por cada cuenta
    accounts = Account.all
    accounts.each do |a|
      # Buscamos todas las menciones
      puts "---> Extrayendo menciones..."

      config = {:count => 200}
      config[:since_id] = a.last_tweet_id unless a.last_tweet_id.nil?
      
      tws = a.tc.mentions(config) # use :since_id instead
      puts "..OK Menciones extraidas capitan!"
      
      # Por cada mencion
      tws.each do |t|
        logger.info " * tweet: " + t.text
        next if Tweet.exists?({:status_id => t.id})
        
        logger.info " ---> Procesando mencion"
        
        # Verificamos si ya existe el profile, sino existe este metodo lo salva
        p = Profile.get t.user.id, a
        
        #prepare date for save into tweets table
        data = self.convert_from_status t
        
        # seteamos datos extras
        data['account_id'] = a.id
        data['profile_id'] = p.id
        
        a.last_tweet_id = t.id
        
        # guardamos el tweet
        t = Tweet.new(data)
        t.save
        
        #actualizamos replied en profile
        p.update_attribute(:replied, true) unless p.replied == true
      end
      a.save
      
    end
    logger.info "mission cumplida"
  end
  
  def self.convert_from_status t
    data = t.to_hash.select{ |k,v| [ 'coordinates', 'created_at',
        'in_reply_to_screen_name', 'in_reply_to_status_id', 
        'in_reply_to_status_id', 'in_reply_to_user_id', 'in_reply_to_user_id_str',
        'retweet_count', 'retweeted', 'source', 'text'
      ].include?(k)
    }
    data['status_id'] = t.id
    data['status_id_str'] = t.id
    
    data
  end

  def extract_dm

  end
end
