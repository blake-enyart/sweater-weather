require 'rails_helper'

describe WeatherSerializer do
  it 'formats data received correctly', :vcr do
    # Need to find way to create fixture for weather_data
    weather = WeatherService.new('denver,co')
    weather_data = weather.next_week
    actual = WeatherSerializer.parse(weather_data)
    main_keys = actual.keys
    expected = [:today_forecast, :daily_forecast, :hourly_forecast]

    expect(main_keys).to eq(expected)

    daily_forecast_keys = actual[:daily_forecast][:day_1].keys
    expected = [:day, :icon, :high, :low, :humidity]

    expect(daily_forecast_keys).to eq(expected)

    hourly_forecast_keys = actual[:hourly_forecast][:hour_1].keys
    expected = [:hour, :icon, :temperature]

    expect(hourly_forecast_keys).to eq(expected)
  end
end
