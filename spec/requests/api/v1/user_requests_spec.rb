require 'rails_helper'

describe 'User API' do
  it "registers a new user via the API", type: :feature do
    user_info = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    page.driver.post('/api/v1/users', user_info)

    expect(page.driver.status_code).to eq(201)
    api_key = Digest::SHA1.hexdigest(user_info[:email])
    expected = JSON.generate({
      "api_key": api_key
    })

    expect(page.driver.response.body).to eq(expected)
    user = User.last

    expect(user.email).to eq("whatever@example.com")
  end
end
