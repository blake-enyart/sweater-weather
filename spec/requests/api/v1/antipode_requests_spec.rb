require 'rails_helper'

describe 'Antipode API' do
  it "returns original city, and the antipode's location name and its current weather summary and current temperature." do
    get '/api/v1/antipode?loc=hongkong'

    expect(response).to be_successful

    expected = {
        "data": [
            {
                "id": "1",
                "type": "antipode",
                "attributes": {
                    "location_name": "Antipode City Name",
                    "forecast": {
                        "summary": "Mostly Cloudy",
                        "current_temperature": "72",
                    				},
                "search_location": "Hong Kong"
                }
            }
        ]
    }
    expect(response.body).to be(expected)
  end
end
