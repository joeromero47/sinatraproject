require './config/environment'

class ApplicationController < Sinatra::Base

  configure do 
    set :public_folder, 'public'
    set :views, 'app/viewers'
    enable :sessions 
    set :session_secret, ENV['SESSION_SECRET']
  end

  get '/' do 
    erb :index
  end 

  helpers do 
    
    def current_user 
      @user = User.find_by_id(session[:user_id])
    end 

    def logged_in?
      !!current_user
    end 

    def redirect_if_not_logged_in
      redirect '/login' unless logged_in?
    end 
  end 
end 