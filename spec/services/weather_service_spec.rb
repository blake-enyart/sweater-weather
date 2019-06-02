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

    expect(dark_sky_service.geocoded_location).to eq(expected)
  end

  it 'returns correct latitude and logitude from Geocoding API' do
    expected = [:latitude, :longitude, :timezone, :currently, :minutely,
                :hourly, :daily, :flags, :offset]

    expect(dark_sky_service.current_weather.keys).to eq(expected)
  end


end
