require 'rails_helper'

RSpec.describe 'As a user' do
  before :each do
    @kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
    @angel = Mechanic.create!(name: 'Angel Breaux', years_experience: 5)

    @outlaw = @kara.rides.create!(name: 'Outlaw Run', thrill_rating: 6, open: true)
    @time_traveler = @kara.rides.create!(name: 'Time Traveler', thrill_rating: 10, open: true)
    @fire_in_the_hole = @kara.rides.create!(name: 'Fire in the Hole', thrill_rating: 4, open: false)

    @thunderation = @angel.rides.create!(name: 'Thunderation', thrill_rating: 4, open: false)
    @wildfire = @angel.rides.create!(name: 'Wildfire', thrill_rating: 7, open: true)

  end

  describe 'When I visit a mechanic show page' do
    it 'I see their name, years of experience, and the names of all rides they’re working on' do
      visit mechanics_path(@kara)

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
      visit mechanics_path(@kara)

      within(".open-rides-list") do
        expect(page).to have_content(@outlaw.name)
        expect(page).to have_content(@time_traveler.name)

        expect(page).not_to have_content(@fire_in_the_hole.name)
      end
    end

    it 'I see rides are listed by thrill rating in descending order (most thrills first)' do
      visit mechanics_path(@kara)

      within(".ride-list")do
        expect(@time_traveler.name).to appear_before(@outlaw.name)
        expect(@outlaw.name).to appear_before(@fire_in_the_hole.name)
        expect(@time_traveler.name).to appear_before(@fire_in_the_hole.name)
      end
    end
  end
end
