require 'rails_helper'

describe 'Antipode API' do
  it "returns original city, and the antipode's location name and its current weather summary and current temperature." do
    get '/api/v1/antipode?loc=hongkong'

    expect(response).to be_successful
    
  end
end
