require 'rails_helper'

describe 'Antipode API' do
  it "returns original city, and the antipode's location name and its current weather summary and current temperature." do
    get '/api/v1/antipode?loc=hongkong'

    antipode_service = AntipodeService.new('hongkong')
    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data]).to be_instance_of(Array)
    expect(parsed[:data][0].keys).to eq([:id, :type, :attributes])
    expected = [:location_name, :forecast, :search_location]
    expect(parsed[:data][0][:attributes].keys).to eq(expected)
    location_name = parsed[:data][0][:attributes][:location_name]
    expect(location_name).to be_instance_of(String)
    forecast = parsed[:data][0][:attributes][:forecast]
    expect(forecast).to be_instance_of(Hash)
    search_location = parsed[:data][0][:attributes][:search_location]
    expect(search_location).to be_instance_of(String)
  end
end
