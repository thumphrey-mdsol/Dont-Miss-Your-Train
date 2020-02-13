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


puts "seeding primary models"
25.times do
    # User.create(user_name: Faker::Name.name, password: "BEEF", email: Faker::Internet.email)
    Station.create(name: Faker::Address.street_address)
end


# Thread.new do
    puts "creating train lines"
    response_string = RestClient.get('http://web.mta.info/status/serviceStatus.txt')
    response_string.gsub!("NQR","NQRW")
    response = JSON.parse(Hash.from_xml(response_string).to_json)
    response["service"]["subway"]["line"][0..-2].each do |line|
        if line["text"] == nil
            line["name"].split("").each{|indiv| 
                Train.create(name: indiv, status: line["status"], status_description: "N/A", img_url: Faker::Avatar.image, destination: "Uptown")
            }
        else
            line["text"] = line["text"].gsub("<br clear=left>"," ")
            elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
            line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: elaboration, img_url: Faker::Avatar.image, destination: "Uptown")}
        end
    end
    response["service"]["subway"]["line"][0..-2].each do |line|
        if line["text"] == nil
            line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: "N/A", img_url: Faker::Avatar.image, destination: "Downtown")}
        else
            line["text"] = line["text"].gsub("<br clear=left>"," ")
            elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
            line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: elaboration, img_url: Faker::Avatar.image, destination: "Downtown")}
        end
    end
# end.join

puts "seeding arrivals"
200.times do
    Arrival.create(station_id:  rand(Station.first.id..Station.last.id), train_id: rand(Train.first.id..Train.last.id), arrival_time: rand(1..24))
    
end