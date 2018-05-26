class WorkoutsController < ApplicationController

  get '/workouts' do
    erb :'/workouts/workouts'
  end

  get '/workouts/new' do
    erb :'/workouts/new'
  end

  post '/workouts/new' do
    # binding.pry
    #creating a new workout, adds it to the user and saves user
    @workout = Workout.create(params[:workout])
    current_user.workouts << @workout

    #create variable to represent movement found by the name in params
    #add row to workout_movements table with all necessary info
    #need to iterate through each workout added in the form
    @movement = Movement.find_by(:name => params[:movement][:name])
    @w_m = WorkoutMovement.create(:workout_id => @workout.id, :movement_id => @movement.id, :weight => params[:weight], :reps => params[:reps])

    redirect to '/workouts'
  end

  get '/workouts/:id' do
    @workout = Workout.find_by_id(params[:id])
    erb :'/workouts/show'
  end

  get '/workouts/:id/edit' do
    @workout = Workout.find_by_id(params[:id])
    # does @w_m need to be an array, so I can put multiple movements in it?
    @w_m = WorkoutMovement.find_by(params[:id])
    @movement = Movement.find_by_id(@w_m.movement_id)
    # binding.pry
    erb :'/workouts/edit'
  end

  patch '/workouts/:id' do

  end

  delete '/workouts/:id' do
    #workouts with id 1 & 2 are not deleting! otherwise it seems to work fine
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
