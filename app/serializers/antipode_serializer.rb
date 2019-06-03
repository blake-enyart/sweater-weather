class AntipodeSerializer
  def self.parse(antipode_data)
    {
    	"data": [{
    		"id": "1",
    		"type": "antipode",
    		"attributes": {
    			"location_name": antipode_data[:antipode_name],
    			"forecast": {
    				"summary": current_forecast(antipode_data[:antipode_weather][:currently],antipode_data[:antipode_weather])[:summary],
    				"current_temperature": current_forecast(antipode_data[:antipode_weather][:currently],antipode_data[:antipode_weather])[:temperature]
    			},
    			"search_location": antipode_data[:main_city]
    		}
    	}]
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
end
