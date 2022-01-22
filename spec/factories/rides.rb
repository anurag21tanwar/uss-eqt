# frozen_string_literal: true

FactoryBot.define do
  factory :ride, class: 'Ride' do
    name { 'some ride' }
    current_capacity { 5 }
    ride_time { 2 }
  end
end
