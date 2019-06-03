require 'rails_helper'

describe 'Forecast API' do
  it 'gets latitude and longitude from Geocoding API' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expected = [:today_forecast, :daily_forecast, :hourly_forecast]
    expect(parsed.keys).to eq(expected)

    today = parsed[:today_forecast]
    expect(today[:date]).to be_instance_of(String)
    expect(today[:summary]).to be_instance_of(String)
    expect(today[:icon]).to be_instance_of(String)
    expect(today[:temperature]).to be_instance_of(Integer)
    expect(today[:high]).to be_instance_of(Integer)
    expect(today[:low]).to be_instance_of(Integer)
    expect(today[:feels_like]).to be_instance_of(Integer)
    expect(today[:humidity]).to be_instance_of(Integer)
    expect(today[:visibility]).to be_instance_of(Float)
    expect(today[:uv_index]).to be_instance_of(Integer)

    day = parsed[:daily_forecast][:day_1]
    expect(day[:day]).to be_instance_of(String)
    expect(day[:icon]).to be_instance_of(String)
    expect(day[:high]).to be_instance_of(Integer)
    expect(day[:low]).to be_instance_of(Integer)
    expect(day[:humidity]).to be_instance_of(Integer)

    hour = parsed[:hourly_forecast][:hour_1]
    expect(hour[:hour]).to be_instance_of(String)
    expect(hour[:icon]).to be_instance_of(String)
    expect(hour[:temperature]).to be_instance_of(Integer)
  end
end
