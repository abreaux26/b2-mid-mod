class MechanicsController < ApplicationController
  def index
    @mechanics = Mechanic.all
  end

  def show
    @mechanic = Mechanic.find(params[:id])
    @mechanic_rides = @mechanic.rides.order_by_thrill_rating
  end
end
