require 'rails_helper'

describe 'User API' do
  it "registers a new user via the API" do
    user_info = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    # converts user_info into JSON in the process
    post '/api/v1/users', as: :json, params: user_info

    # page.driver.post('/api/v1/users', user_info)

    expect(response.status).to eq(201)
    api_key = Digest::SHA1.hexdigest(user_info[:email])
    expected = JSON.generate({
      "api_key": api_key
    })

    expect(response.body).to eq(expected)
    user = User.last

    expect(user.email).to eq("whatever@example.com")
  end
end
