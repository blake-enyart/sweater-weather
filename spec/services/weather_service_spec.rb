require 'rails_helper'

describe WeatherService do
  let(:params) {
    {location: 'denver,co'}
  }

  let(:weather_service) {
    WeatherService.new(params[:location])
  }

  it 'returns attr correctly' do
    expect(weather_service.city).to eq('Denver')
    expect(weather_service.state).to eq('CO')
  end

  it 'returns correct coordinates from Geocoding API', :vcr do
    expected = {
      latitude: 39.7392358,
      longitude: -104.990251
    }
    actual = weather_service.geocoded_location

    expect(actual).to eq(expected)
  end

  # I think I need to test the next week component, but don't know how
end
