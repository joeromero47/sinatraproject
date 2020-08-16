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
      @user = User.create(:email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/bags'
    end
  end

  get '/login' do 
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/games'
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