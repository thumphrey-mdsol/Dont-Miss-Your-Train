class Train < ApplicationRecord
    has_many :arrivals
    has_many :stations, through: :arrivals 
    validates :name, uniqueness: { scope: :destination }
    def sort_timetable
        self.arrivals.sort_by{|arrival| arrival.arrival_time.to_i}
    end
end
