class Movement < ActiveRecord::Base
  has_many :workout_movements
  has_many :workouts, through: :workout_movements
end
