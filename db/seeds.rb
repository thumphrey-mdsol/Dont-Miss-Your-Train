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

puts "creating stations"
puts "creating train lines"
destination_array = ["Uptown", "Downtown"]
subway_info = JSON.parse(RestClient.get('https://data.cityofnewyork.us/resource/kk4q-3rt2.json'))
# subway_info.sort_by{|line| line["name"]}
subway_info.each do |object|
    s = Station.find_or_create_by(name: object["name"])
    s.update(location: object["the_geom"]["coordinates"])
    if object["line"].split("").length > 0
        obj = object["line"].scan(/\w+/)
        obj.each do |line|
            t = Train.find_or_create_by(name: line)
            t.update(destination: destination_array.sample)
            Join.create(station_id: s.id,train_id: t.id)
        end
    end
end

# response_string = RestClient.get('http://web.mta.info/status/serviceStatus.txt')
# response_string.gsub!("NQR","NQRW")
# response = JSON.parse(Hash.from_xml(response_string).to_json)
# response["service"]["subway"]["line"][0..-2].each do |line|
#     if line["text"] == nil
#         line["name"].split("").each{|indiv| 
#                 Train.create(name: indiv, status: line["status"], status_description: "N/A", img_url: Faker::Avatar.image, destination: "Uptown")
#             }
#         else
#             line["text"] = line["text"].gsub("<br clear=left>"," ")
#             elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
#             line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: elaboration, img_url: Faker::Avatar.image, destination: "Uptown")}
#         end
#     end
#     response["service"]["subway"]["line"][0..-2].each do |line|
#         if line["text"] == nil
#             line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: "N/A", img_url: Faker::Avatar.image, destination: "Downtown")}
#         else
#             line["text"] = line["text"].gsub("<br clear=left>"," ")
#             elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
#             line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: elaboration, img_url: Faker::Avatar.image, destination: "Downtown")}
#         end
#     end
    
def arrival_time
    a = rand(0..2).to_s
    b = rand(0..3).to_s
    c = ":"
    d = rand(0..5).to_s
    e = rand(0..9).to_s
    a+b+c+d+e
end
    puts "seeding arrivals"
    1000.times do
        Arrival.create(station_id:  rand(Station.first.id..Station.last.id), train_id: rand(Train.first.id..Train.last.id), arrival_time: arrival_time)
    end