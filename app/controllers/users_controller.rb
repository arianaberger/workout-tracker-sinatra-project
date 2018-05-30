class UsersController < ApplicationController

  get '/signup' do
    #redirect if already signed in?
    erb :'/users/create_user'
  end

  post '/signup' do
    @check_username = User.find_by(:username => params[:user][:username])
    if @check_username
      #flash message is not showing up!
      flash[:message] = "Username taken!"
      redirect to '/signup'
    end

    if params[:username] != "" && params[:password] != "" && !@check_username
      @user = User.create(params[:user])
      session[:user_id] = @user.id #why is this not resetting the user's workouts?
      redirect to '/workouts'
    else
      #flash message is not showing up!
      flash[:message] = "Please fill out both fields"
      redirect to '/signup'
    end
  end

end
