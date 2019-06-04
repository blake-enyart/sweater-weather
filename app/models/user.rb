class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  has_many :favorite_locations
  has_many :locations, through: :favorite_locations
end
