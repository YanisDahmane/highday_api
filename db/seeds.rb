# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning database..."
User.destroy_all

puts "Seeding users..."
User.create([
              {firstname: "Yanis", lastname: "Dahmane", email: "yanis@test.fr", password: "password"},
              {firstname: "Remi", lastname: "De Almeida", email: "remi@test.fr", password: "password"},
              {firstname: "dhayananth", lastname: "dhanasekaran", email: "dhayananth@test.fr", password: "password"}
            ])