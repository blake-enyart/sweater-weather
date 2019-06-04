require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
  end

  describe 'relationships' do
    it { should have_many :favorite_locations }
    it { should have_many(:locations).through :favorite_locations }
  end
end
