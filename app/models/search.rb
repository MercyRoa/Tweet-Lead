class Search < ActiveRecord::Base
  #que haga las busquedas
  
  def process
     # Buscamos todas las menciones
     
      a = Account.oldest_used
      
      config = {:count => 200}
      config[:since_id] = self.last_tweet_id unless self.last_tweet_id.nil?
      
      tws = a.tc.search(self.search + "-rt -http -#ff", :rpp => 200)
      raise tws.to_yaml
      
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
  
end
