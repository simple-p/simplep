# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


users = []
2.times do
  email = Faker::Internet.email
  user = User.create!(name: Faker::Name.name, email:email, password: "123456")
  user.default_avatar
  users << user
end

@user = User.create! name: "Loi", email: "loi@designbold.com", password: "asdfas", created_at: 7.days.ago
@user.default_avatar

@user2 = User.create! name: "Harley", email: "harley@coderschool.vn", password: "asdfas", created_at: 7.days.ago
@user2.default_avatar

n = 30
@team1 = Team.create! name: "DesignBold", created_at: n.days.ago
@team2 = Team.create! name: "CoderSchool", created_at: n.days.ago

@team1.owner = @user
@team1.save!

@team2.owner = @user
@team2.save!

@team1.memberships.create! member: @user, created_at: n.days.ago
@team1.memberships.create! member: @user2,  created_at: n.days.ago

n2 = rand(1..n)
@project = @team1.projects.create! name: "Marketing", created_at:  n2.days.ago
n22 = rand(1..n)
@project2 = @team1.projects.create! name: "Development", created_at:  n22.days.ago


# 10.times do
#   n3 = rand(1..n2)
#   n4 = rand(1..n3)
#   @project.tasks.create! name: Faker::Commerce.product_name, created_at: n3.days.ago, completed_at: n4.days.ago
#   n31 = rand(1..n22)
#   n41 = rand(1..n31)
#   @project2.tasks.create! name: Faker::Commerce.product_name, created_at: n31.days.ago, completed_at: n41.days.ago
# end
#
#
#
