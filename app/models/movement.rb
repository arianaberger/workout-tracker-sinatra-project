class Movement < ActiveRecord::Base
  belongs_to :user
  has_many :workout_movements
  has_many :workouts, through: :workout_movements
end
