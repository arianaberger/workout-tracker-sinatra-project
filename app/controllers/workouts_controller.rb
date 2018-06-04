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
      @user_movements = []
      user_movements(@user_movements)
      erb :'/workouts/new'
    else
      redirect to '/login'
    end
  end

  post '/workouts' do
    if logged_in?
      @workout = Workout.create(params[:workout])
      current_user.workouts << @workout
      update_or_create_movements(params, @workout)
      redirect to '/workouts'
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id' do
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      @workout_movements = []
      collect_workout_movements(@workout_movements, @workout)
      erb :'/workouts/show'
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id/edit' do #NEEDS WORK
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      if @workout && @workout.user == current_user
        @user_movements = [] #gets list of all movements for the user
        user_movements(@user_movements)

        @workout_movements = [] #gathers all movement name and info from join table for this specific workout
        collect_workout_movements(@workout_movements, @workout)

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
      workout = Workout.find_by_id(params[:id])

      # workout_movements = []
      # collect_workout_movements(workout_movements, workout)

      if workout && workout.user_id == current_user.id
        workout.update(params[:workout]) #update name and time of workout WORKS
        binding.pry
        update_or_create_movements(params, workout)
        binding.pry
        redirect to "/workouts/#{workout.id}"
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
    def update_or_create_movements(params, workout)
      wm = collect_wm_for_workout(workout)
      params.each_with_index do |p, i|
        if i != 0 && p[0] != "workout" && p[0] != "id"
          binding.pry
          # movement = Movement.find_by(:name => p[1][:name]) unless p[1][:name] == "select"
            

          wm = WorkoutMovement.find_or_create_by(:workout_id => workout.id, :movement_id => movement.id, :user_id => current_user.id, :weight => p[1][:weight], :reps => p[1][:reps]) unless movement == nil
          wm.update(:workout_id => workout.id, :movement_id => movement.id, :user_id => current_user.id, :weight => p[1][:weight], :reps => p[1][:reps]) unless movement == nil
        end
      end
    end

    def collect_workout_movements(array, workout) #take in an empty array and the workout instance
      WorkoutMovement.all.each do |wm|
        if wm.workout_id == workout.id && wm.user_id == current_user.id
          movement_name = Movement.find_by_id(wm.movement_id).name
          hash = {movement_name => wm}
          array << hash
        end
      end
      array
    end

    def collect_wm_for_workout(workout)
      WorkoutMovement.map do |wm|
        wm.workout_id == workout.id
      end
    end

  end
end
