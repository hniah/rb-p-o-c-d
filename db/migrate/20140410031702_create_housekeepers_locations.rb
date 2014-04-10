class CreateHousekeepersLocations < ActiveRecord::Migration
  def change
    create_table :housekeepers_locations do |t|
      t.references :housekeeper
      t.references :location
    end
  end
end
