require 'rails_helper'

RSpec.describe AmusementPark do
  describe 'relationships' do
    it { should have_many :rides }
  end
end
