class Train < ApplicationRecord
    has_many :arrivals
    has_many :joins
    has_many :stations, through: :joins
    validates :name, uniqueness: { scope: :destination }
    def sort_timetable
        self.arrivals.sort_by{|arrival| arrival.arrival_time.to_i}
    end
    
    def self.refresh
        Rails.logger.info("Refreshing")
        response_string = RestClient.get('http://web.mta.info/status/serviceStatus.txt')
        Rails.logger.info("Got response")
        response_string.gsub!("NQR","NQRW")
        response = JSON.parse(Hash.from_xml(response_string).to_json)
        Rails.logger.info("Made it JSON")
        response["service"]["subway"]["line"][0..-2].each do |line|
            Rails.logger.info("About to make lines")
            if line["text"] == nil
                Rails.logger.info("Making good service line")
                line["name"].split("").each{|indiv| 
                    train = Train.where(name: indiv)
                    train.update(name: indiv, status: line["status"])
                }
            else
                Rails.logger.info("Making delayed line")
                line["text"] = line["text"].gsub("<br clear=left>"," ")
                elaboration = Nokogiri::HTML(CGI.unescapeHTML(line["text"])).content.squish
                line["name"].split("").each{|indiv| 
                    train = Train.where(name: indiv)
                    train.update(name: indiv, status: line["status"], status_description: elaboration)
                }
            end
        end
    end

    def closest_time
       self.sort_timetable.select{|time| time.arrival_time.to_i >= Time.now.hour}[0..3] 
    end
end
