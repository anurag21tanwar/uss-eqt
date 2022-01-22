# frozen_string_literal: true

class CreateRideService
  attr_accessor :name, :current_capacity, :ride_time

  def initialize(params)
    @name = params[:name]
    @current_capacity = params[:current_capacity]
    @ride_time = params[:ride_time]
  end

  def call
    save_ride
    decorate_result
  end

  private

  def save_ride
    Ride.create!(
      {
        name: name, current_capacity: current_capacity, ride_time: ride_time
      }
    )
  end

  def decorate_result
    {
      status: 'ok', message: 'ride successfully created'
    }
  end
end
