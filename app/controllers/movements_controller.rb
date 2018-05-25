class MovementsController < ApplicationController

  get '/movements/new' do
    erb :'movements/new'
  end
end
