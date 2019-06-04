require 'rails_helper'

describe 'Favorites API', type: :feature do
  describe 'happy path' do
    it 'adds favorited cities to user' do
      user = create(:user)
      city = create(:location, city: 'Denver', state:'CO', latitude: 39.7392358, longitude: -104.990251)
      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(user)
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
  end

  describe 'sad path' do
    it 'renders 401 when user attempts to add city to another user' do
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

    it 'renders 401 when user lacks api key' do
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
  end
end
