class MovementsController < ApplicationController

 get '/movements' do
   erb :'/movements/movements'
 end

  get '/movements/new' do
    erb :'movements/new'
  end

  post '/movements/new' do
    @movement = Movement.create(params[:movement])
    redirect to '/movements'
  end
end
