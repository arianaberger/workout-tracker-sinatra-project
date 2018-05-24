class UsersController < ApplicationController

  get '/signup' do
    #redirect if already signed in?
    erb :'/users/create_user'
  end

  post '/signup' do
    #first check if username is taken!
    if params[:username] != "" && params[:password] != ""
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect to '/workouts'
    else
      flash[:message] = "Username taken!"
      redirect to '/signup'
    end
  end

end
