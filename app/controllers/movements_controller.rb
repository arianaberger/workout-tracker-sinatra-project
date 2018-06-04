class MovementsController < ApplicationController

 get '/movements' do
   @user_movements = []
   user_movements(@user_movements)
   erb :'/movements/movements'
 end

  get '/movements/new' do
    erb :'movements/new'
  end

  post '/movements/new' do
    movement = Movement.create(params[:movement])
    current_user.movements << movement
    redirect to '/movements'
  end

end
