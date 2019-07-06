class WorkoutMovement < ActiveRecord::Base
  belongs_to :workout
  belongs_to :movement
  belongs_to :user

  def self.workout_movements(workout, current_user) #this is called on in the Workouts Controller
    self.all.map do |wm|
      if wm.workout_id == workout.id && wm.user_id == current_user.id
        movement_name = Movement.find_by_id(wm.movement_id).name
        return {movement_name => wm}
      end
    end
  end

end
