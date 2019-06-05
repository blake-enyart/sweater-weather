require 'rails_helper'

describe Clients::Flickr do
  let(:flickr) {
    Clients::Flickr.new('Denver', 'CO')
  }

  it 'flickr.photos.search method returns correctly', :vcr do
    expected = [:id, :owner, :secret, :server, :farm, :title, :ispublic, :isfriend, :isfamily]
    actual = flickr.find_photo_info

    expect(actual.keys).to eq(expected)
    expect(actual[:id]).to be_instance_of(String)
    expect(actual[:owner]).to be_instance_of(String)
    expect(actual[:secret]).to be_instance_of(String)
    expect(actual[:server]).to be_instance_of(String)
    expect(actual[:farm]).to be_instance_of(Integer)
    expect(actual[:title]).to be_instance_of(String)
    expect(actual[:ispublic]).to be_instance_of(Integer)
    expect(actual[:isfriend]).to be_instance_of(Integer)
    expect(actual[:isfamily]).to be_instance_of(Integer)
  end

  it 'generates url from found photos' do
    # Webmock fixture because the goal here is generaing the URL
    file = File.open('./spec/fixtures/services/clients/flickr/get_photo_url.yml')
    stub_request(:get, "https://api.flickr.com/services/rest/").
      with(body: file, headers: {})
    actual = flickr.generate_url
    expected = "https://farm6.staticflickr.com/5312/5891370951_b290560390.jpg"

    expect(actual).to eq(expected)
  end
end
