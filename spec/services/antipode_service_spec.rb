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
end
