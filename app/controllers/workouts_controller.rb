class WorkoutsController < ApplicationController

  get '/workouts' do
    erb :'/workouts/workouts'
  end

  get '/workouts/new' do
    erb :'/workouts/new'
  end

  post '/workouts/new' do
    @workout = Workout.create(params[:workout])
    redirect to '/workouts'
  end

  get '/workouts/:id' do

  end

  get '/workouts/:id/edit' do

  end

  patch '/workouts/:id' do

  end

  delete '/workouts/:id/delete' do
    if logged_in?
    @workout = Workout.find_by_id(params[:id])
      if @workout && @workout.user == current_user
        @workout.delete
      end
      redirect to '/workouts'
    else
      redirect to '/login'
    end
  end
end
