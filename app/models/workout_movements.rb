class WorkoutMovement < ActiveRecord::Base
  belongs_to :workout
  belongs_to :movement
end
