class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :style
      t.string :time
      t.string :rounds
      t.integer :user_id
      t.timestamps
    end
  end
end
