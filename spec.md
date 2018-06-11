# Specifications for the Sinatra Assessment

~~~Explain how I have met each requirement before submitting!!~~~

Specs:
- [x] Use Sinatra to build the app
      --> Updated environment.rb with code to require Sinatra environment

- [x] Use ActiveRecord for storing information in a database
      --> Updated environment.rb with code to require ActiveRecord::Base, which also uses sqlite3 and a database

- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
      --> Workouts, Movements, and User classes were used

- [x] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts)
      --> User has many workouts
      --> Movements have many workouts

- [x] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User)
      --> Workouts belong to a user
      --> Movements belong to a user

- [x] Include user accounts
      --> You can sign up and login, links are on the homepage

- [x] Ensure that users can't modify content created by other users
      --> Code checks that user is logged in and that the workout's user id matches the id of the current user

- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
      --> Included for Workouts
      --> partially for Movements (show page is for all movements)

- [x] Include user input validations
      --> Used in the signup and login pages
      --> Validation when Workout has no name and time
      --> There is validation for creating a movement, which needs a name

- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
      --> Signup and login pages show flash messages when there is an error
      --> Movements and workouts pages also have flash message when info is missing

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
