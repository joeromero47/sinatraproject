require './config/environment'

class ApplicationController < Sinatra::Base

  configure do 
    set :public_folder, 'public'
    set :views, 'app/viewers'
    enable :sessions 
    set :session_secret, SecureRandom.hex(64)
  end

  get '/' do 
    erb :index
  end 

  post 'login' do 
    @user = User.find_by(:username => params[:username])
    if @user !=nil && @user.password == params[:password]
      session[:user_id] = @user.id 
      redirect '/welcome'
    else
    erb :error
    end 
  end 
  
  get '/welcome' do
    @current_user = User.find_by(:session[:user_id])
    if @current_user 
      erb :welcome 
    else 
      erb :error 
    end 
  end 


  get '/logout' do 
    session.clear 
    redirect to '/'
  end 

  helpers do 
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that!"
      end 
    end 
    
    def logged_in?
      !!session[:user_id]
    end 
    
    def current_user 
      User.find(session[:user_id])
    end 
  end 
end 