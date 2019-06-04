require 'rails_helper'

describe 'Background API' do
  it 'returns JSON with URL from Flickr API', :vcr do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    expected = JSON.generate({ url: 'https://farm8.staticflickr.com/7884/33433751038_1ccce834d9.jpg' })

    expect(response.body).to eq(expected)
  end
end
