require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    it { should validate_presence_of :city}
  end

  describe 'relationships' do
    it { should have_many :favorite_locations }
    it { should have_many(:users).through :favorite_locations }
  end
end
