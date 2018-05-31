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

  helpers do
    def user_movements(array)
      Movement.all.each do |m|
        if m.user_id == current_user.id
          array << m
        end
      end
      array
    end
  end
end
