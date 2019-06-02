require 'rails_helper'

describe BackgroundService do
  let(:params) {
    {location: 'denver,co'}
  }

  let(:background_service) {
    BackgroundService.new(params[:location])
  }

  it 'returns attr correctly' do
    expect(background.city).to eq('Denver')
    expect(background.state).to eq('CO')
  end

  it 'receives list of popular photos from flickr' do
    expected = 'https://farm8.staticflickr.com/7884/33433751038_1ccce834d9.jpg'

    expect(background_service.get_photo_url).to eq(expected)
  end
end
