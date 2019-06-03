require 'rails_helper'

describe Clients::Amypode do
  let(:geocoded_location) {
    {
        latitude: 22.3193039,
        longitude: 114.1693611
    }
  }

  let(:amypode) {
    Clients::Amypode.new(geocoded_location)
  }

  it 'returns correct antipode coordinates' do
    expected = {
        latitude: -22.3193039,
        longitude: -65.8306389
    }

    expect(amypode.get_antipode_coordinates).to eq(expected)
  end
end
