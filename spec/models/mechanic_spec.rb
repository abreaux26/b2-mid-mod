require 'rails_helper'

RSpec.describe Mechanic do
  describe 'relationships' do
    it { should have_many :ride_mechanics }
    it { should have_many(:rides).through(:ride_mechanics) }
  end

  before :each do
    @kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
    @angel = Mechanic.create!(name: 'Angel Breaux', years_experience: 5)
  end

  describe 'class methocds' do
    it 'returns average years of experience' do
      sum = @kara.years_experience + @angel.years_experience
      average_years_experience = sum / Mechanic.count

      expect(Mechanic.average_years_experience).to eq(average_years_experience)
    end
  end
end
