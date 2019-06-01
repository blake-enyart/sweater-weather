require 'rails_helper'

describe DarkSkyService do
  let(:params) {
    {location: 'denver,co'}
  }

  let(:dark_sky_service) {
    DarkSkyService.new(params[:location])
  }

  it 'returns attr correctly' do
    expect(dark_sky_service.city).to eq('denver')
    expect(dark_sky_service.state).to eq('co')
  end

  it 'returns correct latitude and logitude from Geocoding API' do
    expected = {
      latitude: '39.7392358',
      longitude: '-104.990251'
    }
    
    expect(dark_sky_service.geocoded_location).to eq(expected)
  end
end
