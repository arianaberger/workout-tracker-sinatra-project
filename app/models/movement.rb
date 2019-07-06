class Movement < ActiveRecord::Base
  belongs_to :user
  has_many :workout_movements
  has_many :workouts, through: :workout_movements

  def self.user_movements(current_user)
    self.all.map do |m|
      m.user_id == current_user.id
    end
  end


end
