require 'rails_helper'

describe 'Background API' do
  it 'returns picture from Flickr API' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expected = { url: 'https://farm8.staticflickr.com/7884/33433751038_1ccce834d9.jpg' }
    
    expect(parsed).to eq(expected)
  end
end
