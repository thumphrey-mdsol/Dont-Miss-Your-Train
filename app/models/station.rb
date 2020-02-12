class Station < ApplicationRecord
    has_many :favorites
    has_many :users, through: :favorites
    has_many :arrivals
    has_many :trains, through: :arrivals
end
