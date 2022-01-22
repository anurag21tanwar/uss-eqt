# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ride.create([
              { name: 'Shrek', current_capacity: 10, ride_time: 2 },
              { name: 'Puss in the boots', current_capacity: 5, ride_time: 5 },
              { name: 'The Mummy', current_capacity: 50, ride_time: 7 },
              { name: 'Transformer', current_capacity: 25, ride_time: 4 }
            ])