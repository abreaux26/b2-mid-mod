class AmusementParksController < ApplicationController
  def show
    @park = AmusementPark.find(params[:id])
    @park_rides = @park.rides.order_by_name
  end
end
