class AddRemarkToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :remarks, :text
  end
end
