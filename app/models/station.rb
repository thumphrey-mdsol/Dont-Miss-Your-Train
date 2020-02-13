class Station < ApplicationRecord
    has_many :favorites
    has_many :users, through: :favorites
    has_many :arrivals
    has_many :trains, through: :arrivals


  def self.search(search, id)
      if search
         @stations = Station.where(['name LIKE ?', "%#{search}%"])
      else
         @stations = Station.all
      end
   end
end