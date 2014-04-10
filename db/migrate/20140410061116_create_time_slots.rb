class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string   :category

      t.timestamps

      t.references :user, index: true
      t.references :housekeeper, index: true
    end
  end
end
