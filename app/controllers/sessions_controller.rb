require 'rack-flash'

class SessionsController < ApplicationController
  use Rack::Flash

  get '/login' do
    erb :'/sessions/login'
  end

  post '/login' do
    if params[:username] != "" && params[:password] != ""
      @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/workouts'
        else
          #flash message is not showing up!
          flash[:message] = "Login information incorrect, please try again"
          redirect to '/login'
        end
    else
      #flash message is not showing up!
      flash[:message] = "Please enter a username and password"
      redirect to '/login'
    end
  end

  get '/logout' do
    #this is accessed via a link
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end