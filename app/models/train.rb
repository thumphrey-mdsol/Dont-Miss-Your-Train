class Train < ApplicationRecord
    has_many :arrivals
    has_many :stations, through: :arrivals 
    validates :name, uniqueness: { scope: :destination }
    def sort_timetable
        self.arrivals.sort_by{|arrival| arrival.arrival_time.to_i}
    end
    # def self.refresh
    #     Thread.new do
    #         response_string = RestClient.get('http://web.mta.info/status/serviceStatus.txt')
    #         response_string.gsub!("NQR","NQRW")
    #         response = JSON.parse(Hash.from_xml(response_string).to_json)
    #         response["service"]["subway"]["line"][0..-2].each do |line|
    #             if line["text"] == nil
    #                 line["name"].split("").each{|indiv| 
    #                     train = Train.find{|f|}
    #                     train.update(name: indiv, status: line["status"], status_description: "N/A", img_url: Faker::Avatar.image, destination: "Uptown")
    #                 }
    #             else
    #                 line["text"] = line["text"].gsub("<br clear=left>"," ")
    #                 elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
    #                 line["name"].split("").each{|indiv| 
    #                     train = Train.find{|f| }
    #                     train.update(name: indiv, status: line["status"], status_description: elaboration, img_url: Faker::Avatar.image, destination: "Uptown")
    #                 }
    #             end
    #         end
    #         response["service"]["subway"]["line"][0..-2].each do |line|
    #             if line["text"] == nil
    #                 line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: "N/A", img_url: Faker::Avatar.image, destination: "Downtown")}
    #             else
    #                 line["text"] = line["text"].gsub("<br clear=left>"," ")
    #                 elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
    #                 line["name"].split("").each{|indiv| Train.create(name: indiv, status: line["status"], status_description: elaboration, img_url: Faker::Avatar.image, destination: "Downtown")}
    #             end
    #         end
    #     end.join
    # end

    def closest_time
       self.sort_timetable.select{|time| time.arrival_time.to_i >= Time.now.hour}[0..3] 
    end
end
