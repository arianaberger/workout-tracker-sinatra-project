users = [
  {username: 'yanna', password: 'aaa',},
  {username: 'yanna2', password: 'aaa'}
]

users.each do |u|
  User.create(u)
end

workouts = [
  {name: 'terrible', style: 'emom', time: '30', user_id: 1},
  {name: 'hard', style: 'amrap', time: '20', user_id: 1},
  {name: 'fun', style: 'amrap', time: '15', user_id: 1},
  {name: 'yay', style: 'for_time', time: '25', user_id: 1}
]

workouts.each do |u|
  Workout.create(u)
end

movements = [
  {name: 'deadlift', user_id: 1},
  {name: 'clean', user_id: 1},
  {name: 'snatch', user_id: 1},
  {name: 'pushup', user_id: 1}
]

movements.each do |u|
  Movement.create(u)
end

workout_movements = [
  {workout_id: 1, movement_id: 1, user_id: 1, weight: 85, reps: 5},
  {workout_id: 1, movement_id: 2, user_id: 1, weight: 40, reps: 10},
  {workout_id: 2, movement_id: 1, user_id: 1, weight: 75, reps: 20},
  {workout_id: 3, movement_id: 1, user_id: 1, weight: 65, reps: 3},
  {workout_id: 3, movement_id: 2, user_id: 1, weight: 30, reps: 12}
]

workout_movements.each do |u|
  WorkoutMovement.create(u)
end
