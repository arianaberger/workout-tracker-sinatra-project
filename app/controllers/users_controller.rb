class UsersController < ApplicationController

  get '/signup' do
    #redirect if already signed in?
    erb :'/users/create_user'
  end

  post '/signup' do
    @check_username = User.find_by(:username => params[:user][:username])
    if @check_username
      #flash message is not showing up!
      flash[:message] = "Username taken! Please log in if you already have an account."
      redirect to '/signup'
    end

    if params[:username] != "" && params[:password] != "" && !@check_username
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/workouts'
    else
      flash[:message] = "Please fill out both fields."
      redirect to '/signup'
    end
  end

end
