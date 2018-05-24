class SessionsController < ApplicationController

  get '/login' do
    erb :'/sessions/login'
  end

  post '/login' do
    #find the correct user
    #set session to user id
    #redirect to '/users/workouts'

    #if incorrect, redirect to '/sessions/login' with flash message
    flash[:message] = "Please enter correct login information"
  end

  get '/logout' do
    #this is accessed via a link
    #session.clear
    #redirect to '/'
  end

end
