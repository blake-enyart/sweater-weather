describe BackgroundSerializer do
  let(:data) {
    'https://farm8.staticflickr.com/7884/33433751038_1ccce834d9.jpg'
  }

  it 'serializes data received correctly' do
    expected = { url: 'https://farm8.staticflickr.com/7884/33433751038_1ccce834d9.jpg' }

    expect(BackgroundSerializer.parse(data)).to eq(expected)
  end
end
