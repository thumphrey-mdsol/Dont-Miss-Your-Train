class Train < ApplicationRecord
    has_many :arrivals
    has_many :stations, through: :arrivals 
    validates :name, uniqueness: { scope: :destination }
    def sort_timetable
        self.arrivals.sort_by{|arrival| arrival.arrival_time.to_i}
    end

    def closest_time
        # t = Time.now
       self.sort_timetable.select{|time| time.arrival_time.to_i >= Time.now.hour} 
    end
end
