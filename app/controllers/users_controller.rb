class UsersController < ApplicationController

  get '/signup' do
    erb :'/user/create_user'
  end

  post '/signup' do
    #get params and create a user
    #first check if username is taken!
    #then redirect to /workouts

    #else redirect to /signup with flash message of "username taken"
  end

  get '/workouts' do

  end


  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
