require 'rails_helper'

describe WeatherSerializer do
  it 'formats data received correctly', :vcr do
    # Need to find way to create fixture for weather_data
    weather = WeatherService.new('denver,co')
    weather_data = weather.next_week
    actual = WeatherSerializer.parse(weather_data)
    expected = {
     :today_forecast=>{:date=>"09:53 AM, 06/04", :summary=>"Clear", :icon=>"clear-day", :temperature=>74, :high=>80, :low=>56, :feels_like=>74, :humidity=>30, :visibility=>10, :uv_index=>5},
     :daily_forecast=>
      {:day_1=>{:day=>"Wednesday", :icon=>"partly-cloudy-day", :high=>77, :low=>57, :humidity=>46},
       :day_2=>{:day=>"Thursday", :icon=>"partly-cloudy-day", :high=>79, :low=>58, :humidity=>49},
       :day_3=>{:day=>"Friday", :icon=>"rain", :high=>79, :low=>58, :humidity=>50},
       :day_4=>{:day=>"Saturday", :icon=>"rain", :high=>83, :low=>53, :humidity=>35},
       :day_5=>{:day=>"Sunday", :icon=>"partly-cloudy-day", :high=>67, :low=>54, :humidity=>56}},
     :hourly_forecast=>
      {:hour_1=>{:hour=>"10 AM", :icon=>"clear-day", :temperature=>75},
       :hour_2=>{:hour=>"11 AM", :icon=>"clear-day", :temperature=>79},
       :hour_3=>{:hour=>"12 PM", :icon=>"clear-day", :temperature=>80},
       :hour_4=>{:hour=>"1 PM", :icon=>"partly-cloudy-day", :temperature=>80},
       :hour_5=>{:hour=>"2 PM", :icon=>"partly-cloudy-day", :temperature=>78},
       :hour_6=>{:hour=>"3 PM", :icon=>"partly-cloudy-day", :temperature=>76},
       :hour_7=>{:hour=>"4 PM", :icon=>"partly-cloudy-day", :temperature=>76},
       :hour_8=>{:hour=>"5 PM", :icon=>"partly-cloudy-day", :temperature=>77}}}

    expect(actual).to eq(expected)
  end
end
