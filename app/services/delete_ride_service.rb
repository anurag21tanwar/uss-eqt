# frozen_string_literal: true

class DeleteRideService
  attr_accessor :ride_id

  def initialize(params)
    @ride_id = params[:id]
  end

  def call
    delete_ride
    decorate_result
  end

  private

  def delete_ride
    Ride.find(ride_id).destroy
  end

  def decorate_result
    { status: 'ok', message: 'ride successfully deleted' }
  end
end
