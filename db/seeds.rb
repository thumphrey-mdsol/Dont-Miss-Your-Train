# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destroying users"
User.destroy_all
puts "destroying station"
Station.destroy_all
puts "destroying Subway"
Train.destroy_all
puts "destroying UL"
Favorite.destroy_all
puts "destroying Update"
Arrival.destroy_all


subway_names = ["1","2","A","3","Q","4","S","5","R","W"]
destinations_array = ["Uptown","Downtown"]
status_array = [ "MULTIPLE IMPACTS", "delayed", "good service", "track cleanup", "planned work"]

puts "seeding primary models"
10.times do
    User.create(user_name: Faker::Name.name, password: "BEEF", email: Faker::Internet.email)
    Station.create(name: Faker::Address.street_address)
    Train.create(name: subway_names.sample, color: Faker::Color.color_name, img_url: Faker::Avatar.image, destination: destinations_array.sample, status: status_array.sample)
end


puts "seeding joiner models"
15.times do

    Favorite.create(user_id: rand(User.first.id..User.last.id), station_id: rand(Station.first.id..Station.last.id))

    Arrival.create(station_id:  rand(Station.first.id..Station.last.id), train_id: rand(Train.first.id..Train.last.id), arrival_time: rand(1..24))

end