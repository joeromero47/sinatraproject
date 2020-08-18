class User < ActiveRecord::Base

  has_secure_password
  has_many :games
  
  def self.logged_in?(session)
    !!session[:user_id]
  end 
  
  def self.current_user(session) 
    User.find(session[:user_id])
  end 

end 