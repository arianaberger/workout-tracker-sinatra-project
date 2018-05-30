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
      @workout = Workout.create(params[:workout])
      current_user.workouts << @workout

      update_movements(params, @workout)

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
        @w_m = WorkoutMovement.find_by(:workout_id => @workout.id)
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
      # binding.pry
      @workout = Workout.find_by_id(params[:id])
      movements = []
      movements << WorkoutMovement.find_by(:workout_id => params[:id])
      if @workout && @workout.user == current_user
        @workout.update(params[:workout])
        update_movements(movements)
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

  helpers do
    #need to get this helper method working!
    def update_movements(params, workout)
      #do iteration with #1-5 so the code below isn't repeated?
      #save each movement into an array and iterate of them to create a new WorkoutMovement?
        movement_1 = Movement.find_by(:name => params[:movement_1][:name])
        movement_2 = Movement.find_by(:name => params[:movement_2][:name])
        movement_3 = Movement.find_by(:name => params[:movement_3][:name]) unless params[:movement_3][:name] == "select"
binding.pry
        WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement_1.id, :weight => params[:movement_1][:weight], :reps => params[:movement_1][:reps])
        WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement_1.id, :weight => params[:movement_1][:weight], :reps => params[:movement_1][:reps])
        WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement_3.id, :weight => params[:movement_3][:weight], :reps => params[:movement_3][:reps]) unless movement_3 == nil
    end
  end
end
