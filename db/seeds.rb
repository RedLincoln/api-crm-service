# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all()
Customer.destroy_all()

user1 = User.create!(username: "redlincoln", password: "password")
user2 = User.create!(username: 'Jazmyn2', password: "password2")

customer1 = Customer.create!(name: 'Stanly', surname: 'Herman', creator_id: user1.id, modifier_id: user1.id)
customer1.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'hombre1.jpg')),
  filename: 'hombre1.jpg',
  content_type: 'image/jpeg'
)

customer2 = Customer.create!(name: 'Buster', surname: 'Von', creator_id: user1.id, modifier_id: user1.id)
customer2.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'hombre2.jpg')),
  filename: 'hombre2.jpg',
  content_type: 'image/jpeg'
)

customer3 = Customer.create!(name: 'Granville', surname: 'Klein', creator_id: user2.id, modifier_id: user2.id)
customer3.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'mujer1.jpg')),
  filename: 'mujer1.jpg',
  content_type: 'image/jpeg'
)

Customer.create!(name: 'Cristian', surname: 'D\'Amore', creator_id: user2.id, modifier_id: user2.id)

customer5 = Customer.create!(name: 'Ruth', surname: 'Bernhard', creator_id: user1.id, modifier_id: user1.id)
customer5.photo.attach(
  io: File.open(Rails.root.join('dev', 'img', 'mujer2.jpg')),
  filename: 'mujer2.jpg',
  content_type: 'image/jpeg'
)