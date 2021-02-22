class Ride < ApplicationRecord
  has_many :ride_mechanics
  has_many :mechanics, through: :ride_mechanics

  def self.open_rides
    where(open: true)
  end

  def self.order_by_thrill_rating
    order(thrill_rating: :desc)
  end
end
