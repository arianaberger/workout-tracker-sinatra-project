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
    if logged_in?
      if params[:movement][:name] == ""
        flash[:message] = "Please enter a movement name."
        redirect to '/movements/new'
      end

      if Movement.all.find_by(:name => params[:movement][:name], :user_id => current_user.id)
        flash[:message] = "That movement already exists."
        redirect to '/movements/new'
      else
        movement = Movement.create(params[:movement])
        current_user.movements << movement
        redirect to '/movements'
      end
    else
      redirect to '/login'
    end
  end

  delete '/movements/:id' do
      if logged_in?
      @movement = Movement.find_by_id(params[:id])
        if @movement && @movement.user == current_user
          @movement.delete
        end
        redirect to '/movements'
      else
        redirect to '/login'
      end
  end

end
