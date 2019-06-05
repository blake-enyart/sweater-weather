require 'rails_helper'

describe BackgroundService do
  let(:params) {
    {location: 'denver,co'}
  }

  let(:background_service) {
    BackgroundService.new(params[:location])
  }

  it 'returns attr correctly' do
    expect(background_service.city).to eq('Denver')
    expect(background_service.state).to eq('CO')
  end

  it 'receives list of popular photos from flickr', :vcr do
    expected = 'https://farm6.staticflickr.com/5312/5891370951_b290560390.jpg'

    expect(background_service.get_photo_url).to eq(expected)
  end
end
