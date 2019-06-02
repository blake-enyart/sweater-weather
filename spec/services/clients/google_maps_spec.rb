describe Clients::GoogleMaps do
  let(:geocode) {
    Clients::GoogleMaps.new('Denver', 'CO')
  }

  it 'returns correct coordinates' do
    skip 'Should test with VCR to ensure endpoint'
    expected = {
      latitude: 39.7392358,
      longitude: -104.990251
    }
    actual = geocode.coordinates

    expect(actual).to eq(expected)
  end
end
