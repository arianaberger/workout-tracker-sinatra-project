class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :workout_movements
  has_many :movements, through: :workout_movements
end
