# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
@angel = Mechanic.create!(name: 'Angel Breaux', years_experience: 5)

@outlaw = @kara.rides.create!(name: 'Outlaw Run', thrill_rating: 6, open: true)
@time_traveler = @kara.rides.create!(name: 'Time Traveler', thrill_rating: 10, open: true)
@fire_in_the_hole = @kara.rides.create!(name: 'Fire in the Hole', thrill_rating: 4, open: false)

@thunderation = @angel.rides.create!(name: 'Thunderation', thrill_rating: 4, open: false)
@wildfire = @angel.rides.create!(name: 'Wildfire', thrill_rating: 7, open: true)
@powderkey = @angel.rides.create!(name: 'Powderkeg', thrill_rating: 8, open: true)
