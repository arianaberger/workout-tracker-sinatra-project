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
      Movement.user_movements(current_user)
      erb :'/workouts/new'
    else
      redirect to '/login'
    end
  end

  post '/workouts' do
    if logged_in?
      if params[:workout][:name] == "" || params[:workout][:time] == ""
        @params = params
        flash[:message] = "Please enter at least a workout name and time."
        @user_movements = [] #how to remove this and make one line with below?
        user_movements(@user_movements)
        erb :'/workouts/new'
      else
        workout = current_user.workouts.build(params[:workout])
        if workout.save
          create_or_update_workout(params, workout)
          redirect to "/workouts/#{workout.id}"
        else
          flash[:message] = "There was an error, please try again."
          erb :'/workouts'
        end
      end
    else
      redirect to '/login'
    end
  end


#///////// @workout_movements isn't working properly, check in WorkoutMovement.rb for method
#It's returning a hash with one movement
  get '/workouts/:id' do
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      if @workout && @workout.user == current_user
        @workout_movements = WorkoutMovement.workout_movements(@workout, current_user)

        # @workout_movements = []
        # collect_workout_movements(@workout_movements, @workout)
        erb :'/workouts/show'
      else
        redirect to '/workouts'
      end
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id/edit' do
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      if @workout && @workout.user == current_user
        # @user_movements = [] #can refactor this just like below too
        # user_movements(@user_movements) #gets list of all movements saved for the user

        @user_movements = Movement.user_movements

        # @workout_movements = []
        # collect_workout_movements(@workout_movements, @workout) #gets all info from join table for this specific workout

        @workout_movements = WorkoutMovement.workout_movements(@workout, current_user)

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
      if workout && workout.user_id == current_user.id
        workout.update(params[:workout])
        create_or_update_workout(params, workout) #links to helper method below
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
    workout = Workout.find_by_id(params[:id])
      if workout && workout.user == current_user
        workout.delete
      end
      redirect to '/workouts'
    else
      redirect to '/login'
    end
  end


  helpers do
    def create_or_update_workout(params, workout)
      wm_array = []
      collect_workout_movements(wm_array, workout)
      if wm_array.empty? #checks if it is a new workout
        create_workout_movements(params, workout)
      else
        wm_array.each do |wm| #otherwise delete currently save workout_movements
          wm.values[0].destroy
        end
        create_workout_movements(params, workout)
      end
    end


    def create_workout_movements(params, workout)
      params.each_with_index do |p, i|
        if p[0].include?("movement") && p[1][:name] != "select"
          movement = Movement.all.find_by(:name => p[1][:name], :user_id => current_user.id)
          WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement.id, :user_id => current_user.id, :weight => p[1][:weight], :reps => p[1][:reps])
        end
      end
    end

    end

end
