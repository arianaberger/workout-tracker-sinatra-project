class MovementsController < ApplicationController

 get '/movements' do
   erb :'/movements/movements'
 end

  get '/movements/new' do
    erb :'movements/new'
  end

  post '/movements/new' do
    
  end
end
