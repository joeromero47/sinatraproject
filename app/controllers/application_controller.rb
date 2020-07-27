require './config/environment'

class ApplicationController < Sinatra::Base

  config do 
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :welcome 
  end 

  get '/test' do 
    "hello test"
  end 



end 