require 'rails_helper'

describe 'User API' do
  it "registers a new user via the API", type: :feature do
    user_info = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    page.driver.post('/api/v1/users', user_info)
    page.driver.status_code.should eql 201
    user = User.last

    expect(user.email).to eq("whatever@example.com")
    expect(user.password).to eq("password")

    api_key = Digest::SHA1.hexdigest(user_info['email'])
    expected = {
      "api_key": api_key,
    }

    expect(response.body).to eq(expected)
  end
end
