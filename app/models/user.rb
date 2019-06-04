class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  has_many :favorite_locations
  has_many :locations, through: :favorite_locations

  def fav_city_names
    favorite_locations = Location.joins(:users).where(favorite_locations: {user_id: self.id}).pluck('locations.city, locations.state')
    favorite_locations = favorite_locations.map do |location|
      location.join(',')
    end
  end
end
