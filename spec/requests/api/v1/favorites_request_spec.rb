require 'rails_helper'

describe 'Favorites API' do
  describe 'happy path' do
    let(:user) {
      create(:user)
    }
    let(:city) {
      create(:location, city: 'Denver', state:'CO', latitude: 39.7392358, longitude: -104.990251)
    }

    it 'adds favorited cities to user', :vcr do
      denver = create(:location, city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
      boulder = create(:location, city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
      rifle = create(:location, city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
      favorited_city = {
        location: "Denver, CO",
        api_key: user.api_key
      }

      expect(user.locations.count).to eq(0)

      post '/api/v1/favorites', as: :json, params: favorited_city

      expect(response.status).to eq(201)
      user.reload

      expect(user.locations.count).to eq(1)
    end

    it 'returns JSON with list of favorite cities and current weather', :vcr do
      # Must have fixed lat/long becuase they are used in URI path generation
      denver = create(:location, city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
      boulder = create(:location, city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
      rifle = create(:location, city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
      user.locations << [denver, fort_collins, boulder]
      credentials = {
        api_key: user.api_key
      }
      get '/api/v1/favorites', as: :json, params: credentials

      expect(response.status).to eq(200)
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed.count).to eq(3)
    end

    it 'delete favorite city from list', :vcr do
      # Must have fixed lat/long becuase they are used in URI path generation
      denver = create(:location, city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
      boulder = create(:location, city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
      rifle = create(:location, city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
      user.locations << [denver, fort_collins, boulder]

      credentials = {
        api_key: user.api_key
      }

      expect(user.locations.count).to eq(3)

      delete_info = {
        location: 'Denver, CO',
        api_key: user.api_key
      }
      delete '/api/v1/favorites', as: :json, params: delete_info

      expect(response.status).to eq(200)

      user.reload

      expect(user.locations.count).to eq(2)

      parsed = JSON.parse(response.body, symbolize_names: true)
      parsed_locations = parsed.map do |location_forecast|
        location_forecast[:location]
      end
      expected = [ "Fort Collins,CO","Boulder,CO"]

      expect(parsed_locations).to eq(expected)
    end
  end

  describe 'sad path' do
    it 'renders 401 when api key not in database and want to create', :vcr do
      user = create(:user)
      city = create(:location, city: 'Denver', state:'CO', latitude: 39.7392358, longitude: -104.990251)
      favorited_city = {
        location: 'Denver, CO',
        api_key: 'wrongkey'
      }

      post '/api/v1/favorites', as: :json, params: favorited_city

      expect(response.status).to eq(401)
    end

    it 'renders 401 when user lacks api key and want to create', :vcr do
      user = create(:user, api_key: nil)
      city = create(:location, city: 'Denver', state:'CO', latitude: 39.7392358, longitude: -104.990251)
      favorited_city = {
        location: 'Denver, CO',
        api_key: user.api_key
      }

      post '/api/v1/favorites', as: :json, params: favorited_city

      expect(response.status).to eq(401)
    end

    it 'renders 401 when attempt to lookup user favorites with wrong key', :vcr do
      user = create(:user)
      denver = create(:location, city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
      boulder = create(:location, city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
      rifle = create(:location, city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
      user.locations << [denver, fort_collins, boulder]
      credentials = {
        api_key: 'wrongkey'
      }
      get '/api/v1/favorites', as: :json, params: credentials

      expect(response.status).to eq(401)
    end

    it 'renders 401 when user lacks api key and attempts to lookup favorites', :vcr do
      user = create(:user, api_key: nil)
      denver = create(:location, city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
      boulder = create(:location, city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
      rifle = create(:location, city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
      user.locations << [denver, fort_collins, boulder]
      credentials = {
        api_key: user.api_key
      }
      get '/api/v1/favorites', as: :json, params: credentials

      expect(response.status).to eq(401)
    end

    it "renders 401 when bad user attempts to delete another user's favorites", :vcr do
      user = create(:user)
      denver = create(:location, city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
      boulder = create(:location, city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
      rifle = create(:location, city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
      user.locations << [denver, fort_collins, boulder]

      delete_info = {
        location: 'Denver, CO',
        api_key: 'wrongkey'
      }
      delete '/api/v1/favorites', as: :json, params: delete_info

      expect(response.status).to eq(401)
    end

    it "renders 401 when user lacks api key and tries to delete favorites", :vcr do
      user = create(:user, api_key: nil)
      denver = create(:location, city: 'Denver', state: 'CO', latitude: 39.742043, longitude: -104.991531)
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO', latitude: 40.585258, longitude: -105.084419)
      boulder = create(:location, city: 'Boulder', state: 'CO', latitude: 40.014984, longitude: -105.270546)
      rifle = create(:location, city: 'Rifle', state: 'CO', latitude: 39.534702, longitude: -107.783119)
      user.locations << [denver, fort_collins, boulder]

      delete_info = {
        location: 'Denver, CO',
        api_key: user.api_key
      }

      delete '/api/v1/favorites', as: :json, params: delete_info

      expect(response.status).to eq(401)
    end
  end
end
