require 'rails_helper'

RSpec.describe FavoriteLocation, type: :model do
  describe 'relationships' do
    it { should belong_to :location }
    it { should belong_to :user }
  end
end
