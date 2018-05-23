class UsersController < ApplicationController

  get '/signup' do

  end

  post 'signup' do

  end

  get 'login' do

  end

  post 'login' do

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
