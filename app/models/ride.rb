class Ride < ApplicationRecord
  has_many :ride_mechanics
  has_many :mechanics, through: :ride_mechanics
  belongs_to :amusement_park

  def self.open_rides
    where(open: true)
  end

  def self.order_by_thrill_rating
    order(thrill_rating: :desc)
  end

  def self.order_by_name
    order(:name)
  end

  def self.average_thrill_rating
    average(:thrill_rating).to_f.round(2)
  end
end
