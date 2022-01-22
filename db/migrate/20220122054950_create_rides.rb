# frozen_string_literal: true

class CreateRides < ActiveRecord::Migration[6.1]
  def change
    create_table :rides do |t|
      t.string :name
      t.integer :current_capacity
      t.integer :ride_time
      t.string :status, default: 'H', null: false
      t.integer :queue_length, default: 0, null: false

      t.timestamps

      t.index :id
    end
  end
end
