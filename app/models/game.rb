class Game < ActiveRecord::Base 

  belongs_to :user
  

  def self.current_user(session) 
    User.find(session[:user_id])
  end 
  
end 