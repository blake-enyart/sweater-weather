require 'rails_helper'

describe 'Sessions API' do
  it 'logins in a user via the API' do
    user = create(:user)
    login_info = {
      "email": user.email,
      "password": user.password
    }

    post '/api/v1/sessions', as: :json, params: login_info

    expect(response.status).to eq(200)
    expected = JSON.generate({
      "api_key": user.api_key,
    })
    expect(response.body).to eq(expected)
  end
end
