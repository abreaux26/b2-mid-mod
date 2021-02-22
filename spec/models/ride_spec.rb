require 'rails_helper'

RSpec.describe Ride do
  describe 'relationships' do
    it { should have_many :ride_mechanics }
    it { should have_many(:mechanics).through(:ride_mechanics) }
  end

  before :each do
    @outlaw = Ride.create!(name: 'Outlaw Run', thrill_rating: 6, open: true)
    @time_traveler = Ride.create!(name: 'Time Traveler', thrill_rating: 10, open: true)
    @fire_in_the_hole = Ride.create!(name: 'Fire in the Hole', thrill_rating: 4, open: false)
  end

  describe 'class methods' do
    it 'returns open rides only' do
      rides = Ride.open_rides
      expected = [@outlaw, @time_traveler]
      bad = [@fire_in_the_hole]

      expect(rides).to eq(expected)
      expect(rides).not_to include(bad)
    end
  end
end
