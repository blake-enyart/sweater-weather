require 'rails_helper'

describe 'Sessions API' do
  it 'logins in a user via the API', type: :feature do
    user = create(:user)
    login_info = {
      "email": "whatever@example.com",
      "password": "password"
    }

    page.driver.post('/api/v1/sessions', login_info)

    expect(page.driver.status_code).to eq(200)
    expected = JSON.generate({
      "api_key": user.api_key,
    })
    expect(page.driver.response.body).to eq(expected)

  end
end
