require 'rails_helper'

describe Clients::Flickr do
  let(:flickr) {
    Clients::Flickr.new('Denver', 'CO')
  }

  it 'finds photos correctly' do
    skip 'Should test with VCR'
    expected = {
                "id": "33433751038",
                "owner": "62401943@N06",
                "secret": "1ccce834d9",
                "server": "7884",
                "farm": 8,
                "title": "Denver skyline",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0
            }
    actual = flickr.find_photo_info

    expect(actual).to eq(expected)
  end

  it 'generates url from found photos' do
    actual = flickr.generate_url
    expected = 'https://farm8.staticflickr.com/7884/33433751038_1ccce834d9.jpg'

    expect(actual).to eq(expected)
  end
end
