class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps

      t.references :user, index: true
      t.references :housekeeper, index: true
    end
  end
end
