# frozen_string_literal: true

class UpdateRideService
  attr_accessor :ride_id, :current_capacity, :status

  def initialize(params)
    @ride_id = params[:id]
    @current_capacity = params[:current_capacity]
    @status = params[:status]
  end

  def call
    update_ride
    decorate_result
  end

  private

  def update_ride
    Ride.find(ride_id).update!(current_capacity: current_capacity, status: status)
  end

  def decorate_result
    { status: 'ok', message: 'ride successfully patched' }
  end
end
