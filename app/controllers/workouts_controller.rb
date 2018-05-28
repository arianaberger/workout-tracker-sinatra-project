require 'rack-flash'

class WorkoutsController < ApplicationController

  get '/workouts' do
    if logged_in?
      @workouts = current_user.workouts
      erb :'/workouts/workouts'
    else
      redirect to '/login'
    end
  end

  get '/workouts/new' do
    if logged_in?
      erb :'/workouts/new'
    else
      redirect to '/login'
    end
  end

  post '/workouts' do #NEED INTERATION THROUGH EACH MOVEMENT
    if logged_in?
    #creating a new workout, adds it to the user and saves user
      @workout = Workout.create(params[:workout])
      current_user.workouts << @workout
    #create variable to represent movement found by the name in params
    #add row to workout_movements table with all necessary info
    #need to iterate through each workout added in the form
      @movement = Movement.find_by(:name => params[:movement][:name])
      @w_m = WorkoutMovement.create(:workout_id => @workout.id, :movement_id => @movement.id, :weight => params[:weight], :reps => params[:reps])
      redirect to '/workouts'
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id' do
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      @movements = []
      @movements << WorkoutMovement.find_by_id(@workout.id)
      erb :'/workouts/show'
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id/edit' do #NEEDS WORK
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      if @workout && @workout.user == current_user
        # does @w_m need to be an array, so I can put multiple movements in it?
        @w_m = WorkoutMovement.find_by(params[:id])
        #how to iterate through the movements and match them up so they are properly selected in edit form?
        @movement = Movement.find_by_id(@w_m.movement_id)
        erb :'/workouts/edit'
      else
        redirect to '/workouts'
      end
    else
      redirect to '/login'
    end
  end

  patch '/workouts/:id' do
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      if @workout && @workout.user == current_user
        @workout.update(params[:workout])
        @movement = Movement.find_by(:name => params[:movement][:name])
        @w_m = WorkoutMovement.update(:workout_id => @workout.id, :movement_id => @movement.id, :weight => params[:weight], :reps => params[:reps])
        redirect to "/workouts/#{@workout.id}"
      else
        redirect to '/workouts'
      end
    else
      redirect to '/login'
    end
  end

  delete '/workouts/:id' do
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
