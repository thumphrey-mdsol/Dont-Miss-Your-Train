class Train < ApplicationRecord
    has_many :arrivals
    has_many :stations, through: :arrivals 
    validates :name, uniqueness: { scope: :destination }
end
