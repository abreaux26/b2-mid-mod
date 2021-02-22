require 'rails_helper'

RSpec.describe Ride do
  describe 'relationships' do
    it { should have_many :ride_mechanics }
    it { should have_many(:mechanics).through(:ride_mechanics) }
    it { should belong_to :amusement_park }
  end

  before :each do
    @sdc = AmusementPark.create!(name: 'Silver Dollar City', price: 60.50)

    @outlaw = Ride.create!(name: 'Outlaw Run', thrill_rating: 6, open: true, amusement_park_id: @sdc.id)
    @time_traveler = Ride.create!(name: 'Time Traveler', thrill_rating: 10, open: true, amusement_park_id: @sdc.id)
    @fire_in_the_hole = Ride.create!(name: 'Fire in the Hole', thrill_rating: 4, open: false, amusement_park_id: @sdc.id)
  end

  describe 'class methods' do
    it 'returns open rides only' do
      rides = Ride.open_rides
      expected = [@outlaw, @time_traveler]
      bad = [@fire_in_the_hole]

      expect(rides).to eq(expected)
      expect(rides).not_to include(bad)
    end

    it 'returns rides by thrill rating in descending order' do
      rides = Ride.order_by_thrill_rating
      expected = [@time_traveler, @outlaw, @fire_in_the_hole]

      expect(rides).to eq(expected)
    end

    it 'returns rides in alphabetical order' do
      rides = Ride.order_by_name
      expected = [@fire_in_the_hole, @outlaw, @time_traveler]

      expect(rides).to eq(expected)
    end

    it 'returns average thrill rating' do
      sum = @outlaw.thrill_rating + @time_traveler.thrill_rating + @fire_in_the_hole.thrill_rating
      average_thrill_rating = (sum.to_f / Ride.count).round(2)

      expect(Ride.average_thrill_rating).to eq(average_thrill_rating)
    end
  end
end
