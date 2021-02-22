class RideMechanicsController < ApplicationController
  def create
    @mechanic = Mechanic.find(params[:mechanic_id])
    @ride = Ride.find(params[:id])
    @mechanic.rides << @ride
    redirect_to "/mechanics/#{@mechanic.id}"
  end
end
