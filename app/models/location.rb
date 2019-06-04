class Location < ApplicationRecord
  validates_presence_of :city, :latitude, :longitude
  has_many :favorite_locations
  has_many :users, through: :favorite_locations
end
