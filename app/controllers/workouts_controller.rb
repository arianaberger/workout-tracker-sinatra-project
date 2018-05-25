class WorkoutsController < ApplicationController

  get '/workouts' do
    erb :'/workouts/workouts'
  end

  get '/workouts/new' do
    erb :'/workouts/new'
  end

  post '/workouts/new' do
    binding.pry
    @workout = Workout.create(params[:workout])
    #iterate through each workout_movement and add weight and reps and movement, but same workout id
    @workout_movement = Workout_Movement.create(:movement_id => :weight => params[:workout_movements][:weight], :reps => params[:workout_movements][:reps])
    @workout_movement.update(:workout_id => @workout.id)
    @workout_movement.save
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
