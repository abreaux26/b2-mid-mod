require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @sdc = AmusementPark.create!(name: 'Silver Dollar City', price: 60.50)
    @six_flags = AmusementPark.create!(name: 'Six Flags', price: 70.00)

    @kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
    @angel = Mechanic.create!(name: 'Angel Breaux', years_experience: 5)

    @outlaw = @kara.rides.create!(name: 'Outlaw Run', thrill_rating: 6, open: true, amusement_park_id: @sdc.id)
    @time_traveler = @kara.rides.create!(name: 'Time Traveler', thrill_rating: 10, open: true, amusement_park_id: @sdc.id)
    @fire_in_the_hole = @kara.rides.create!(name: 'Fire in the Hole', thrill_rating: 4, open: false, amusement_park_id: @sdc.id)

    @thunderation = @angel.rides.create!(name: 'Thunderation', thrill_rating: 4, open: false, amusement_park_id: @sdc.id)
    @wildfire = @angel.rides.create!(name: 'Wildfire', thrill_rating: 7, open: true, amusement_park_id: @sdc.id)
    @powderkeg = @angel.rides.create!(name: 'PowderKeg', thrill_rating: 8, open: true, amusement_park_id: @sdc.id)
  end

  describe 'When I visit an amusement parks show page' do
    it 'I see the name and price of admissions for that amusement park' do
      visit amusement_park_path(@sdc)

      expect(current_path).to eq("/amusement_parks/#{@sdc.id}")

      within("#park-#{@sdc.id}") do
        expect(page).to have_content(@sdc.name)
        expect(page).to have_content(@sdc.price)
        expect(page).not_to have_content(@six_flags.name)
        expect(page).not_to have_content(@six_flags.price)
      end
    end

    it 'I see the names of all the rides that are at that theme park' do
      visit amusement_park_path(@sdc)

      within("#park-#{@sdc.id}") do
        expect(page).to have_content(@outlaw.name)
        expect(page).to have_content(@time_traveler.name)
        expect(page).to have_content(@fire_in_the_hole.name)
        expect(page).to have_content(@thunderation.name)
        expect(page).to have_content(@wildfire.name)
        expect(page).to have_content(@powderkeg.name)
      end
    end

    it 'I see rides listed in alphabetical order' do
      visit amusement_park_path(@sdc)

      within("#park-#{@sdc.id}") do
        expect(@fire_in_the_hole.name).to appear_before(@outlaw.name)
        expect(@outlaw.name).to appear_before(@powderkeg.name)
        expect(@powderkeg.name).to appear_before(@thunderation.name)
        expect(@thunderation.name).to appear_before(@time_traveler.name)
        expect(@time_traveler.name).to appear_before(@wildfire.name)
      end
    end

    xit 'I see the average thrill rating of this amusement parks ride' do

    end
  end
end
