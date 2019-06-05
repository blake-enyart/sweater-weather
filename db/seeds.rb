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

denver = Location.create(city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
fort_collins = Location.create(city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
boulder = Location.create(city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
rifle = Location.create(city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
user.locations << [denver, fort_collins, boulder]
