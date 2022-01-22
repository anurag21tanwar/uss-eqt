# frozen_string_literal: true

class QueueRideService
  attr_accessor :ride_id, :operation

  def initialize(params, operation)
    @ride_id = params[:id]
    @operation = operation
  end

  def call
    perform_operation
    decorate_result
  end

  private

  def perform_operation
    Ride.find(ride_id).adjust_queue(operation)
  end

  def decorate_result
    { status: 'ok', message: 'adjustment of ride queue length successfully completed' }
  end
end
