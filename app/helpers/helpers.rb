require 'sinatra/base'

class Helpers

  def self.current_user(session)
    @user = User.find_by_id(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end
  
  def logged_in_user
    unless current_user?(@model.user)
      flash[:danger] = "You do not have authorization to edit this post" #if not logged in as the owner of the post
      redirect_to login_url
    end
   end
end