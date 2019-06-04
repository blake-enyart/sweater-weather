require 'rails_helper'

describe 'Favorites API', type: :feature do
  describe 'happy path' do
    it 'adds favorited cities to user' do
      user = create(:user)
      favorited_city = {
        location: 'Denver, CO',
        api_key: user.api_key
      }

      expect(user.cities.count).to eq(0)

      page.driver.post('/api/v1/favorites', favorited_city)

      expect(page.driver.status_code).to eq(200)

      user.reload
      
      expect(user.cities.count).to eq(1)
    end
  end
end
