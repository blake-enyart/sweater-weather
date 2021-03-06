require 'rails_helper'

describe 'Background API' do
  it 'returns JSON with URL from Flickr API', :vcr do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    expected = JSON.generate({ url: 'https://farm6.staticflickr.com/5312/5891370951_b290560390.jpg' })

    expect(response.body).to eq(expected)
  end
end
