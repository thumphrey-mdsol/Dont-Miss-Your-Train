class User < ApplicationRecord
    has_secure_password
    has_many :favorites
    has_many :stations, through: :favorites
    validates :user_name, uniqueness: true
    validates :email, presence: true
end
