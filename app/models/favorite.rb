class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :station
    validates :user_id, uniqueness: { scope: :station_id,
    message: "You already favorited this station!" }
end
