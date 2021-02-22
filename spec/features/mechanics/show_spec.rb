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
    @powderkey = @angel.rides.create!(name: 'PowderKeg', thrill_rating: 8, open: true, amusement_park_id: @sdc.id)
  end

  describe 'When I visit a mechanic show page' do
    it 'I see their name, years of experience, and the names of all rides they’re working on' do
      visit mechanic_path(@kara)
      expect(current_path).to eq("/mechanics/#{@kara.id}")

      within("#mechanic-#{@kara.id}") do
        expect(page).to have_content(@kara.name)
        expect(page).to have_content(@kara.years_experience)
        expect(page).not_to have_content(@angel.name)
        expect(page).not_to have_content(@angel.years_experience)
      end

      within(".ride-list")do
        expect(page).to have_content(@outlaw.name)
        expect(page).to have_content(@time_traveler.name)
        expect(page).to have_content(@fire_in_the_hole.name)

        expect(page).not_to have_content(@thunderation.name)
        expect(page).not_to have_content(@wildfire.name)
      end
    end

    it 'I only see rides that are open' do
      visit mechanic_path(@kara)

      within(".open-rides-list") do
        expect(page).to have_content(@outlaw.name)
        expect(page).to have_content(@time_traveler.name)

        expect(page).not_to have_content(@fire_in_the_hole.name)
      end
    end

    it 'I see rides are listed by thrill rating in descending order (most thrills first)' do
      visit mechanic_path(@kara)

      within(".ride-list")do
        expect(@time_traveler.name).to appear_before(@outlaw.name)
        expect(@outlaw.name).to appear_before(@fire_in_the_hole.name)
        expect(@time_traveler.name).to appear_before(@fire_in_the_hole.name)
      end
    end
  end
end
