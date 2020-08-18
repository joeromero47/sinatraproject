class UsersController < ApplicationController
  
  get 'users/:id' do 
    if !logged_in? 
      redirect '/games'
    end 
    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/games'
    end
  end
  
  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      redirect to '/games'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(:email => params[:email], :password => params[:password])
      session[:user_id] = user.id
      redirect '/games'
    end
  end

  get '/login' do 
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/games'
    else
      @error = "invalid credentials"
      erb 'users/login'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end 