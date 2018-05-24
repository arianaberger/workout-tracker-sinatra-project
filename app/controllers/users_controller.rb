class UsersController < ApplicationController

  get '/signup' do
    #redirect if already signed in?
    erb :'/users/create_user'
  end

  post '/signup' do
    @check_username = User.find_by(:username => params[:username])
    if @check_username = User.find_by(:username => params[:username])
      flash[:message] = "Username taken!"
      redirect to '/signup'
    end

    if params[:username] != "" && params[:password] != ""
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/workouts'
    else
      flash[:message] = "Please fill out both fields"
      redirect to '/signup'
    end
  end

end
