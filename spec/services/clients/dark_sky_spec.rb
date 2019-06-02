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

  it 'gets weather correctly' do
    skip "Need VCR to test syntax of response is correct"
  end
end
