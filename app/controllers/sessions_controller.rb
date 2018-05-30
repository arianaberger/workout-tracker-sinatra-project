class SessionsController < ApplicationController

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
          flash[:message] = "Login information incorrect, please try again."
          redirect to '/login'
        end
    else
      flash[:message] = "Please fill out both fields."
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
