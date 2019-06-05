# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FavoriteLocation.destroy_all
User.destroy_all
Location.destroy_all

user = User.create(email: 'test@gmail.com', password: 'password', api_key: 'test')

denver = Location.create(city: 'Denver', state: 'CO', latitude: 25.111, longitude: 25.2222)
fort_collins = Location.create(city: 'Fort Collins', state: 'CO', latitude: 50.111, longitude: 50.2222)
boulder = Location.create(city: 'Boulder', state: 'CO', latitude: 75.111, longitude: 75.2222)
rifle = Location.create(city: 'Rifle', state: 'CO', latitude: 100.111, longitude: 100.2222)
user.locations << [denver, fort_collins, boulder]
