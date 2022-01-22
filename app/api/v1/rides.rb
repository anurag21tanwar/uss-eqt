# frozen_string_literal: true

module V1
  class Rides < Grape::API
    include V1::Defaults

    resource :rides do
      desc 'list rides information'
      params do
      end

      get do
        FetchRidesService.new.call
      end

      desc 'create a ride'
      params do
        requires :name, type: String
        requires :current_capacity, type: String
        requires :ride_time, type: Integer
      end

      post do
        CreateRideService.new(params).call
      end

      desc 'update a ride'
      params do
        requires :id, type: Integer
        requires :current_capacity, type: String
        requires :status, type: String, values: %w[H MF NW]
      end

      patch ':id' do
        UpdateRideService.new(params).call
      end

      desc 'delete a ride'
      params do
        requires :id, type: Integer
      end

      delete ':id' do
        DeleteRideService.new(params).call
      end

      desc 'ride queue in'
      params do
        requires :id, type: Integer
      end

      patch ':id/in' do
        QueueRideService.new(params, 'IN').call
      end

      desc 'ride queue out'
      params do
        requires :id, type: Integer
      end

      patch ':id/out' do
        QueueRideService.new(params, 'OUT').call
      end

      desc 'reset ride queue length'
      params do
        requires :id, type: Integer
      end

      patch ':id/reset' do
        ResetRidesService.new(params).call
      end
    end
  end
end
