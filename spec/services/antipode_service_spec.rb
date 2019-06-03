require 'rails_helper'

describe AntipodeService do
  let(:params) {
    {loc: 'hongkong'}
  }

  let(:antipode_service) {
    AntipodeService.new(params[:loc])
  }

  it 'returns attr correctly' do
    expect(antipode_service.city).to eq('Hong Kong')
  end

  it 'gets coordinates based on city name' do
    expected = {
                    latitude: 22.3193039,
                    longitude: 114.1693611
                }

    expect(antipode_service.geocoded_location).to eq(expected)
  end

  it 'gets antipode coordinates based on city' do
    expected = {
                latitude: -22.3193039,
                longitude: -65.8306389
            }

    expect(antipode_service.get_antipode).to eq(expected)
  end

  it 'get antipode name' do
    expected = "Jujuy, Argentina"

    expect(antipode_service.antipode_name).to eq(expected)
  end

  it 'gets weather in antipode city' do
  end
end
