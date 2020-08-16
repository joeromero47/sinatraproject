class GamesController < ApplicationController

  get "/games" do
   redirect_if_not_logged_in
   @games = Games.all
   erb :'golf_bags/index'
  end

  get "/games/new" do 
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'games/new'
  end

  get "/games/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @games = Games.find(params[:id])
    erb :'games/edit'
  end

  post "/bags/:id" do 
    redirect_if_not_logged_in
    @games = Games.find(params[:id])
    unless Games.valid_params?(params)
      redirect "/games/#{@games.id}/edit?error=invalid golf bag"
    end
    @games.update(params.select{|k|k=="name" || k=="platform"})
    redirect "/games/#{@games.id}"
  end 

  get "/games/:id" do
    redirect_if_not_logged_in
    @games = Games.find(params[:id])
    erb :'games/show'
  end

  post "/games" do 
    redirect_if_not_logged_in

    unless Games.valid_params?(params)
      redirect "/games/new?error=invalid game"
    end
    Games.create(params)
    redirect "/games"
  end 


end 
