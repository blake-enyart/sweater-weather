class WeatherSerializer

  def self.parse(weather_data)
    {
      today_forecast: current_forecast(weather_data[:currently], weather_data),
      daily_forecast: {
        day_1: daily_forecast(weather_data[:daily][:data][1]),
        day_2: daily_forecast(weather_data[:daily][:data][2]),
        day_3: daily_forecast(weather_data[:daily][:data][3]),
        day_4: daily_forecast(weather_data[:daily][:data][4]),
        day_5: daily_forecast(weather_data[:daily][:data][5])
      },
      hourly_forecast: {
        hour_1: hourly_forecast(weather_data[:hourly][:data][1]),
        hour_2: hourly_forecast(weather_data[:hourly][:data][2]),
        hour_3: hourly_forecast(weather_data[:hourly][:data][3]),
        hour_4: hourly_forecast(weather_data[:hourly][:data][4]),
        hour_5: hourly_forecast(weather_data[:hourly][:data][5]),
        hour_6: hourly_forecast(weather_data[:hourly][:data][6]),
        hour_7: hourly_forecast(weather_data[:hourly][:data][7]),
        hour_8: hourly_forecast(weather_data[:hourly][:data][8])
      }
    }
  end

  def self.current_forecast(today, weather_data)
    {
      date: Time.at(today[:time]).to_datetime.strftime('%H:%M %p, %m/%d'),
      summary: today[:summary],
      icon: today[:icon],
      temperature: today[:temperature].round,
      high: weather_data[:daily][:data][0][:temperatureHigh].round,
      low: weather_data[:daily][:data][0][:temperatureLow].round,
      feels_like: today[:apparentTemperature].round,
      humidity: (today[:humidity] * 100).to_i,
      visibility: today[:visibility],
      uv_index: today[:uvIndex]
    }
  end

  def self.daily_forecast(day_data)
    {
      day: Time.at(day_data[:time]).to_datetime.strftime('%A'),
      icon: day_data[:icon],
      high: day_data[:temperatureHigh].round,
      low: day_data[:temperatureLow].round,
      humidity: (day_data[:humidity] * 100).to_i
    }
  end

  def self.hourly_forecast(hour_data)
    {
      hour: Time.at(hour_data[:time]).to_datetime.strftime('%l %p').strip,
      icon: hour_data[:icon],
      temperature: hour_data[:temperature].round
    }
  end
end
