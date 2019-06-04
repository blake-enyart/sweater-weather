require 'rails_helper'

describe Clients::DarkSky do
  let(:geocoded_location) {
    {
      latitude: 39.7392358,
      longitude: -104.990251
    }
  }

  let(:dark_sky) {
    Clients::DarkSky.new(geocoded_location)
  }

  it 'DarkSky API returns in correct syntax', :vcr do
    actual = dark_sky.get_weather
    expected = [:latitude, :longitude, :timezone, :currently, :minutely,
                :hourly, :daily, :flags, :offset]

    expect(actual.keys).to eq(expected)
    expect(actual[:latitude]).to be_instance_of(Float)
    expect(actual[:longitude]).to be_instance_of(Float)
    expect(actual[:timezone]).to be_instance_of(String)
    expect(actual[:currently]).to be_instance_of(Hash)
    expect(actual[:minutely]).to be_instance_of(Hash)
    expect(actual[:hourly]).to be_instance_of(Hash)
    expect(actual[:daily]).to be_instance_of(Hash)
    expect(actual[:flags]).to be_instance_of(Hash)
    expect(actual[:offset]).to be_instance_of(Integer)
  end
end
