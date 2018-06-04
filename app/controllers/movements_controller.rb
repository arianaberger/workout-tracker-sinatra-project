class MovementsController < ApplicationController

 get '/movements' do
   if logged_in?
     @user_movements = []
     user_movements(@user_movements)
     erb :'/movements/movements'
   else
     redirect to '/login'
   end
 end

  get '/movements/new' do
    if logged_in?
      erb :'movements/new'
    else
      redirect to '/login'
    end
  end

  post '/movements/new' do
    movement = Movement.create(params[:movement])
    current_user.movements << movement
    redirect to '/movements'
  end

end
