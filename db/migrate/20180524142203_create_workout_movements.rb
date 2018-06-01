class CreateWorkoutMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :workout_movements do |t|
      t.integer :workout_id
      t.integer :movement_id
      t.integer :user_id
      t.integer :reps
      t.integer :weight
    end
  end
end
