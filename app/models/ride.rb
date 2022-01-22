# frozen_string_literal: true

class Ride < ApplicationRecord
  default_scope { order(:name) }

  validates :name, :current_capacity, :ride_time, presence: true

  def wait_time
    if status == 'H'
      ((queue_length / current_capacity) * ride_time)
    else
      'Infinity'
    end
  end

  def health_status
    {
      'H' => 'Healthy',
      'MF' => 'Malfunction',
      'NW' => 'Not working'
    }.fetch(status, 'Healthy')
  end

  def adjust_queue(operation)
    case operation
    when 'IN'
      update!(queue_length: queue_length + 1)
    when 'OUT'
      update!(queue_length: queue_length - 1) if queue_length.positive?
    end
  end

  def reset_queue
    update!(queue_length: 0)
  end
end
