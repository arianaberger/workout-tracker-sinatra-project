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
      @movements = []
      user_movements(@movements)
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
      collect_movements(@movements, @workout)
      # binding.pry
      erb :'/workouts/show'
    else
      redirect to '/login'
    end
  end

  get '/workouts/:id/edit' do #NEEDS WORK
    if logged_in?
      @workout = Workout.find_by_id(params[:id])
      if @workout && @workout.user == current_user
        @movements = []
        collect_movements(@movements, @workout)
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
        movement_1 = Movement.find_by(:name => params[:movement_1][:name]) unless params[:movement_1][:name] == "select"
        movement_2 = Movement.find_by(:name => params[:movement_2][:name]) unless params[:movement_2][:name] == "select"
        movement_3 = Movement.find_by(:name => params[:movement_3][:name]) unless params[:movement_3][:name] == "select"

        WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement_1.id, :weight => params[:movement_1][:weight], :reps => params[:movement_1][:reps]) unless movement_1 == nil
        WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement_1.id, :weight => params[:movement_2][:weight], :reps => params[:movement_2][:reps]) unless movement_2 == nil
        WorkoutMovement.create(:workout_id => workout.id, :movement_id => movement_3.id, :weight => params[:movement_3][:weight], :reps => params[:movement_3][:reps]) unless movement_3 == nil
    end

    def collect_movements(array, workout)
      WorkoutMovement.all.each do |wm|
        if wm.workout_id == workout.id
          array << wm
        end
      end
      array
    end
  end
end

#trying to get the hash working otherwise I have to find the movement name in the view page!!
# also tried just doing this in one line, but --> I can't remove the LIMIT=1 !
# @movements << WorkoutMovement.find_each(:workout_id => params[:id])

  #   def collect_movements(array, workout)
  #     WorkoutMovement.all.each do |wm|
  #       binding.pry
  #       if wm.workout_id == workout.id
  #         movement = Movement.find_by_id(wm.movement_id)
  #         hash = {movement.name => {
  #           weight: wm.weight,
  #           reps: wm.reps
  #           }}
  #         array << hash
  #         binding.pry
  #       end
  #     end
  #     array
  #   end
  # end
