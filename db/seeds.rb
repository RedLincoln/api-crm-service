# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Role.destroy_all
Customer.destroy_all


standard = Role.create!(name: 'standard', description: 'The user can manage basic resources')
admin = Role.create!(name: 'admin', description: 'The user can manage other users')

user1 = User.create!(username: "redlincoln", password: "password", email: "example@example.com", role: standard)
user2 = User.create!(username: 'Jazmyn2', password: "password2", email: "example2@example.com", role: standard)
User.create!(username: 'admin_user', password: 'password', email: "admin_user@test.com", role: admin)
User.create!(username: 'test50', password: 'password', email: "test50@test.com", role: admin)


customer1 = Customer.create!(name: 'Stanly', surname: 'Herman', creator: user1, modifier: user1)
customer1.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'hombre1.jpg')),
  filename: 'hombre1.jpg',
  content_type: 'image/jpeg'
)

customer2 = Customer.create!(name: 'Buster', surname: 'Von', creator: user1, modifier: user1)
customer2.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'hombre2.jpg')),
  filename: 'hombre2.jpg',
  content_type: 'image/jpeg'
)

customer3 = Customer.create!(name: 'Granville', surname: 'Klein', creator: user2, modifier: user2)
customer3.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'mujer1.jpg')),
  filename: 'mujer1.jpg',
  content_type: 'image/jpeg'
)

Customer.create!(name: 'Cristian', surname: 'D\'Amore', creator: user2, modifier: user2)

customer5 = Customer.create!(name: 'Ruth', surname: 'Bernhard', creator: user1, modifier: user1)
customer5.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'mujer2.jpg')),
  filename: 'mujer2.jpg',
  content_type: 'image/jpeg'
)