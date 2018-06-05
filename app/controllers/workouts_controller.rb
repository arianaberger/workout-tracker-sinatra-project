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
      create_or_update_workout(params, @workout)
      binding.pry
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
      if workout && workout.user_id == current_user.id
        workout.update(params[:workout])
        create_or_update_workout(params, workout)
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

    def collect_workout_movements(array, workout) #take in an empty array and the workout instance
      WorkoutMovement.all.each do |wm|
        if wm.workout_id == workout.id && wm.user_id == current_user.id
          movement_name = Movement.find_by_id(wm.movement_id).name
          hash = {movement_name => wm}
          array << hash
        end
      end
      array #do I need to output the original array here?
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

    #last attempt
    # def update_or_create_movements(params, workout)
    #   wm_array = []
    #   collect_wm_for_workout(wm_array, workout) #gets the current movements saved for this workout
    #   params.each_with_index do |p, i|
    #     if !wm_array.empty?
    #       if p[0] == "movement_#{i-1}"
    #         movement = Movement.all.find_by(:name => p[i+1][:name], :user_id => current_user.id)
    #         binding.pry
    #         wm_array[i].update(:workout_id => workout.id, :movement_id => movement.id, :user_id => current_user.id, :weight => p[1][:weight], :reps => p[1][:reps])
    #       end
    #     elsif p[0] == "select"
    #       binding.pry
    #       wm_array[i].destroy
    #     else
    #       binding.pry
    #       movement = Movement.all.find_by(:name => p[i+1][:name], :user_id => current_user.id)
    #       WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement.id, :user_id => current_user.id, :weight => p[1][:weight], :reps => p[1][:reps])
    #     end
    #   end
    # end




    #
    #   if !wm_array.empty?
    #     params.each_with_index do |p, i|
    #       if p[0] == "movement_#{i-1}" #checks for correct params values
    #       #gets the corresponding movement instance - could be streamlined? Use other method??
    #         movement = Movement.all.find_by(:name => p[1][:name], :user_id => current_user.id)
    #         if wm_array[i] != nil && p[1][:name] != "select"
    #           wm_array[i].update(:workout_id => workout.id, :movement_id => movement.id, :user_id => current_user.id, :weight => p[1][:weight], :reps => p[1][:reps])
    #         elsif p[0] == "select"
    #           wm_array[i].destroy
    #         end
    #       end
    #     end
    #   else
    #     params.each_with_index do |p, i|
    #       binding.pry
    #       movement = Movement.all.find_by(:name => p[1][:name], :user_id => current_user.id)
    #       binding.pry
    #       WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement.id, :user_id => current_user.id, :weight => p[1][:weight], :reps => p[1][:reps])
    #     end
    #   end
    # end
