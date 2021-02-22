require 'rails_helper'

RSpec.describe 'As a user' do
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
    @powderkeg = Ride.create!(name: 'PowderKeg', thrill_rating: 8, open: true, amusement_park_id: @sdc.id)
  end

  describe 'When I go to a mechanics show page' do
    it 'I see a form to add a ride to their workload' do
      visit mechanic_path(@angel)

      expect(page).to have_button('Submit')
    end
  end

  describe 'I fill in that field with an id of an existing ride' do
    it 'I hit submit and am taken back to that mechanics show page' do
      visit mechanic_path(@angel)

      fill_in :id, with: @powderkeg.id
      click_button('Submit')

      expect(current_path).to eq("/mechanics/#{@angel.id}")
    end

    it 'I see the name of that newly added ride on this mechanics show page' do
      visit mechanic_path(@angel)

      fill_in :id, with: @powderkeg.id
      click_button('Submit')

      within(".ride-list") do
        expect(page).to have_content('PowderKeg')
      end
    end
  end
end

# Add a ride to workload:
# Ride Id: _pretend_this_is_a_textfield_
# Submit
