class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :time
      t.integer :user_id
      t.datetime :uploaded_at
    end
  end
end
