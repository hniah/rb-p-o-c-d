class CreateBlockedTimeSlots < ActiveRecord::Migration
  def change
    create_table :blocked_time_slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string   :category

      t.timestamps

      t.references :time_slot, index: true
    end
  end
end
