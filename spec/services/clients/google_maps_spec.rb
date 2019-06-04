require 'rails_helper'

describe Clients::GoogleMaps do
  let(:geocode) {
    Clients::GoogleMaps.new('Denver', 'CO')
  }

  it 'returns correct coordinates', :vcr do
    actual = geocode.coordinates

    expect(actual[:latitude]).to be_instance_of(Float)
    expect(actual[:longitude]).to be_instance_of(Float)
  end
end
