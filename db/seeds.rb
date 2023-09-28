# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning database..."
Event.destroy_all
User.destroy_all

puts "Seeding users..."
yanis = User.create({firstname: "Yanis", lastname: "Dahmane", email: "yanis@test.fr", password: "password"})
remi = User.create({firstname: "Remi", lastname: "De Almeida", email: "remi@test.fr", password: "password"})
dhayananth = User.create({firstname: "dhayananth", lastname: "dhanasekaran", email: "dhayananth@test.fr", password: "password"})

puts "Seeding events..."

event = Event.create({owner: yanis, title: "Event 1", description: "Description 1", start_at: DateTime.now, end_at: DateTime.now + 1.hour})
event.members << remi
event.members << dhayananth