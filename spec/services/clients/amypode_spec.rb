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
        data: {
            id: "1",
            type: "antipode",
            attributes: {
                lat: -22.3193039,
                long: -65.8306389
            }
        }
    }

    expect(amypode.get_antipode).to eq(expected)
  end
end
