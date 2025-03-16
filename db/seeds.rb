# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create a default admin user
admin = User.find_or_create_by!(email_address: "admin@johnsproject.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.admin = true
end

# Create a default user
john = User.find_or_create_by!(email_address: "john.vannamen@hubruxelles.be") do |john|
  john.password = "password"
  john.password_confirmation = "password"
  john.admin = false
  john.firstname = "John"
  john.lastname = "Vannamen"
end

user = User.find_or_create_by!(email_address: "el.salim.salim@gmail.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.admin = false
  user.firstname = "Salim"
  user.lastname = "JOLY"
end

# Create a default project
project = Project.find_or_create_by!(name: "Project 1") do |project|
  project.description = "This is a project"
  project.user = user
end

# Create a default task 1
task1 = Task.find_or_create_by!(
  name: "Task 1",
  project: project,
  user: john,
  criticity: 0,
  status: :new,
  start_date: Date.today,
  due_date: Date.today + 1.month
) do |task1|
  task1.description = "This is a task"
  task1.remarks = "This is a remark"
end

# Create a default task 2
task2 = Task.find_or_create_by!(
  name: "Task 2",
  project: project,
  user: john,
  criticity: 3,
  status: :new,
  start_date: Date.today,
  due_date: Date.today + 1.month
) do |task2|
  task2.description = "This is a task"
  task2.remarks = "This is a remark"
end

# Create a default task 3
task3 = Task.find_or_create_by!(
  name: "Task 3",
  project: project,
  user: john,
  criticity: 5,
  status: :new,
  start_date: Date.today,
  due_date: Date.today + 1.month
) do |task3|
  task3.description = "This is a task"
  task3.remarks = "This is a remark"
end

# Create a default task 4
task4 = Task.find_or_create_by!(
  name: "Task 4",
  project: project,
  user: john,
  criticity: 7,
  status: :new,
  start_date: Date.today,
  due_date: Date.today + 1.month
) do |task4|
  task4.description = "This is a task"
  task4.remarks = "This is a remark"
end

# Create a default task 5
task5 = Task.find_or_create_by!(
  name: "Task 5",
  project: project,
  user: user,
  criticity: 0,
  status: :new,
  start_date: Date.today,
  due_date: Date.today + 1.month
) do |task5|
  task5.description = "This is a task"
  task5.remarks = "This is a remark"
end

# Create a default task 6
task6 = Task.find_or_create_by!(
  name: "Task 6",
  project: project,
  user: user,
  criticity: 10,
  status: :new,
  start_date: Date.today,
  due_date: Date.today + 1.month
) do |task6|
  task6.description = "This is a task"
  task6.remarks = "This is a remark"
end