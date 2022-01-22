# frozen_string_literal: true

class FetchRidesService
  attr_accessor :rides

  def call
    fetch_all_rides
    decorate_result
  end

  private

  def fetch_all_rides
    @rides = Ride.all
  end

  def decorate_result
    { status: 'ok', rides: rides_info }
  end

  def rides_info
    rides.map do |ride|
      {
        id: ride.id,
        name: ride.name,
        capacity: ride.current_capacity,
        ride_time: ride.ride_time,
        wait_time: ride.wait_time,
        queue_length: ride.queue_length,
        status: ride.health_status
      }
    end
  end
end
