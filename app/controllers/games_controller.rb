class GamesController < ApplicationController

  get "/games" do
    redirect_if_not_logged_in
      @games = current_user.games
      erb :'games/index'
  end

  get "/games/new" do 
    redirect_if_not_logged_in
    erb :'games/new'
  end

  post '/games' do 
    redirect_if_not_logged_in
    if params[:name] == "" || params[:platform] == ""
      redirect '/games/index'
    else
      game = current_user.games.build(params)
      game.save
      redirect "games/#{game.id}"
    end 
  end 

  get '/games/:id' do
    redirect_if_not_logged_in
    @games = current_user.games
    erb :'/games/index'
  end

  get "/games/:id/edit" do
    set_game
    erb :'games/edit'
  end

  post "/games/:id" do 
    set_game
    @games.update(params.select{|k|k=="name" || k=="platform"})
    redirect "/games/#{@games.id}"
  end

  put '/games/:id' do 
    @editgame = Game.find(params[:id])
    if @editgame.user_id != current_user[:user_id]
      redirect '/games/index'
    else 
      params.delete(:_method)
      set_game
      @games.update(params)
      redirect '/games'
    end 
  end 

  delete '/games/:id' do
    @games = Game.delete(params[:id])
    redirect to("/games")
  end

  private

  def set_game
    @games = current_user.games.find_by_id(params[:id])
  end 
end


