require 'rails_helper'

describe 'Forecast API' do
  it 'gets coordinates from Geocoding API', :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)

    expected = [:today_forecast, :daily_forecast, :hourly_forecast]
    endpoint_keys = parsed.keys
    
    expect(endpoint_keys).to eq(expected)

    today_expected = [:date, :summary, :icon, :temperature, :high, :low, :feels_like,
                :humidity, :visibility, :uv_index]
    today_keys = parsed[:today_forecast].keys

    expect(today_keys).to eq(today_expected)

    day_expected = [:day, :icon, :high, :low, :humidity]
    day_keys = parsed[:daily_forecast][:day_1].keys

    expect(day_keys).to eq(day_expected)

    hour_expected = [:hour, :icon, :temperature]
    hour_keys = parsed[:hourly_forecast][:hour_1].keys

    expect(hour_keys).to eq(hour_expected)
  end
end
