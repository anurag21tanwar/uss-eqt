# frozen_string_literal: true

class ResetRidesService
  attr_accessor :ride_id

  def initialize(params)
    @ride_id = params[:id]
  end

  def call
    reset_ride_count
    decorate_result
  end

  private

  def reset_ride_count
    Ride.find(ride_id).reset_queue
  end

  def decorate_result
    { status: 'ok', message: 'reset of ride queue count successfully completed' }
  end
end
