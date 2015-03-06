class AddFieldsTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :status, :string
  end
end
