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

      # Por cada mencion
      tws.each do |t|
        next if Tweet.exists?({:status_id => t.id})
        
        logger.info " ---> Procesando mencion"
        # Verificamos si ya existe el profile
        p = Profile.find_by_twitter_id t.user.id
        # si no existe lo guardamos
        if p.nil?
          logger.info "  --> !No existe: "+t.user.screen_name
          data = t.user.to_hash.select{ |k,v| [
              'description', 'followers_count', 'friends_count',
              'lang', 'location', 'name', 'profile_image_url',
              'screen_name', 'protected', 'time_zone', 'url', 'utc_offset'].include?(k) }
          
          data['twitter_id'] = t.user.id
          p = Profile.new(data)
          # p.twitter_id = t.user.id
          p.save
        end

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
    logger.info "mission cumplida"
  end

  def extract_dm

  end
end
