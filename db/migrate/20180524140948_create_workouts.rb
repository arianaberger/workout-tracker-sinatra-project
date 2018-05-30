class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :time
      t.integer :user_id
      t.timestamp
    end
  end
end
