require 'rails_helper'

describe WeatherService do
  let(:params) {
    {location: 'denver,co'}
  }

  let(:dark_sky_service) {
    WeatherService.new(params[:location])
  }

  it 'returns attr correctly' do
    expect(dark_sky_service.city).to eq('Denver')
    expect(dark_sky_service.state).to eq('CO')
  end

  it 'returns correct latitude and logitude from Geocoding API' do
    expected = {
      latitude: 39.7392358,
      longitude: -104.990251
    }
    actual = dark_sky_service.geocoded_location

    expect(actual).to eq(expected)
  end

  it 'returns correct keys from DarkSky API' do
    skip 'Need webmock to mock up the DarkSky API response'
    actual = dark_sky_service.next_week
    
    expect(actual).to eq(expected)
  end


end
