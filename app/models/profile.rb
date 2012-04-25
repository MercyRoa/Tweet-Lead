class Profile < ActiveRecord::Base
  has_many :tweets
  belongs_to :account
  
  # User can be String, Integer or Twitter::User
  def self.make_from(user, account = nil)
    logger.info " * Creando Profile"
    
    if !user.respond_to? "to_hash"
      account = Account.first if account.nil?
      user = account.tc.user user
    end
    
    return false if user.nil? 

    data = user.to_hash.select{ |k,v| [
        'description', 'followers_count', 'friends_count',
        'lang', 'location', 'name', 'profile_image_url',
        'screen_name', 'protected', 'time_zone', 'url', 'utc_offset'].include?(k) }
    
    data['twitter_id'] = user.id
    
    p = self.new(data)
    p.save
    p #p.save returs true, so we have to return full profile object
  end
  
  # Check and create 
  def self.get(user, account = nil)
    logger.info " Buscando Usuario: "+user
    if user.is_a? String
      p = self.find_by_screen_name user
    elsif user.is_a? Integer
      p = self.find_by_twitter_id user
    end

    #regresamos p si existe
    return p unless p.nil?
    
    # si no existe lo intentamos guardar
    self.make_from user, account
  end
end
