require 'rails_helper'

RSpec.describe 'As a user' do
  before :each do
    @kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
    @angel = Mechanic.create!(name: 'Angel Breaux', years_experience: 5)
  end

  describe 'When I visit the mechanics index page' do
    it 'I see a header saying "All Mechanics"' do
      visit mechanics_path

      expect(page).to have_content("All Mechanics")
    end

    it 'I see a list of all mechanic’s names and their years of experience' do
      visit mechanics_path

      within("#mechanics-list") do
        expect(page).to have_content(@kara.name)
        expect(page).to have_content(@kara.years_experience)
        expect(page).to have_content(@angel.name)
        expect(page).to have_content(@angel.years_experience)
      end
    end

    it 'I see the average years of experience across all mechanics' do
      visit mechanics_path

      expect(page).to have_content('8.0')
    end
  end
end
