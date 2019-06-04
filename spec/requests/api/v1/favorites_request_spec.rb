require 'rails_helper'

describe 'Favorites API', type: :feature do
  describe 'happy path' do
    let(:user) {
      create(:user)
    }
    let(:city) {
      create(:location, city: 'Denver', state:'CO', latitude: 39.7392358, longitude: -104.990251)
    }
    before(:each) do
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)
    end

    it 'adds favorited cities to user', :vcr do
      favorited_city = {
        location: city.id,
        api_key: user.api_key
      }

      expect(user.locations.count).to eq(0)

      page.driver.post('/api/v1/favorites', favorited_city)

      expect(page.driver.status_code).to eq(201)

      user.reload

      expect(user.locations.count).to eq(1)
    end

    it 'returns JSON with list of favorite cities and current weather', :vcr do
      denver = create(:location, city: 'Denver', state: 'CO')
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO')
      boulder = create(:location, city: 'Boulder', state: 'CO')
      rifle = create(:location, city: 'Rifle', state: 'CO')
      user.locations << [denver, fort_collins, boulder]
      credentials = {
        api_key: user.api_key
      }
      page.driver.get('/api/v1/favorites', credentials)

      expect(page.driver.status_code).to eq(200)
      parsed = JSON.parse(page.driver.response.body, symbolize_names: true)

      expect(parsed.count).to eq(3)
    end

    it 'delete favorite city from list', :vcr do
      denver = create(:location, city: 'Denver', state: 'CO')
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO')
      boulder = create(:location, city: 'Boulder', state: 'CO')
      rifle = create(:location, city: 'Rifle', state: 'CO')
      user.locations << [denver, fort_collins, boulder]

      credentials = {
        api_key: user.api_key
      }
      page.driver.get('/api/v1/favorites', credentials) # Initial number of favorites
      parsed = JSON.parse(page.driver.response.body, symbolize_names: true)

      expect(parsed.count).to eq(3)

      delete_info = {
        location: denver.id,
        api_key: user.api_key
      }
      page.driver.delete('/api/v1/favorites', delete_info)

      expect(page.driver.status_code).to eq(200)

      parsed = JSON.parse(page.driver.response.body, symbolize_names: true)

      expect(parsed.count).to eq(2)
    end
  end

  describe 'sad path' do
    it 'renders 401 when user attempts to add city to another user', :vcr do
      user = create(:user)
      bad_user = create(:user)
      city = create(:location, city: 'Denver', state:'CO', latitude: 39.7392358, longitude: -104.990251)
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(bad_user)
      favorited_city = {
        location: city.id,
        api_key: user.api_key
      }

      page.driver.post('/api/v1/favorites', favorited_city)
      expect(page.driver.status_code).to eq(401)
    end

    it 'renders 401 when user lacks api key', :vcr do
      user = create(:user, api_key: nil)
      city = create(:location, city: 'Denver', state:'CO', latitude: 39.7392358, longitude: -104.990251)
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)
      favorited_city = {
        location: city.id,
        api_key: user.api_key
      }

      page.driver.post('/api/v1/favorites', favorited_city)
      expect(page.driver.status_code).to eq(401)
    end

    it 'renders 401 when bad user attempts to lookup another user favorites', :vcr do
      user = create(:user)
      bad_user = create(:user)
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(bad_user)

      denver = create(:location, city: 'Denver', state: 'CO')
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO')
      boulder = create(:location, city: 'Boulder', state: 'CO')
      rifle = create(:location, city: 'Rifle', state: 'CO')
      user.locations << [denver, fort_collins, boulder]
      credentials = {
        api_key: user.api_key
      }
      page.driver.get('/api/v1/favorites', credentials)
      expect(page.driver.status_code).to eq(401)
      # Need to figure out how to test this...
    end

    it 'renders 401 when user lacks api key and attempts to lookup favorites', :vcr do
      user = create(:user, api_key: nil)
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)

      denver = create(:location, city: 'Denver', state: 'CO')
      fort_collins = create(:location, city: 'Fort Collins', state: 'CO')
      boulder = create(:location, city: 'Boulder', state: 'CO')
      rifle = create(:location, city: 'Rifle', state: 'CO')
      user.locations << [denver, fort_collins, boulder]
      credentials = {
        api_key: user.api_key
      }
      page.driver.get('/api/v1/favorites', credentials)
      expect(page.driver.status_code).to eq(401)
      # Need to figure out how to test this...
    end
  end
end
