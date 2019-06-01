require 'rails_helper'

describe 'Forecast API' do
  it 'gets latitude and longitude from Geocoding API' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:latitude]).to eq('39.7392358')
    expect(parsed[:longitude]).to eq('-104.990251')
  end
end
