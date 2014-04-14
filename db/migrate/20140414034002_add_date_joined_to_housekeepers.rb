class AddDateJoinedToHousekeepers < ActiveRecord::Migration
  def change
    add_column :housekeepers, :date_joined, :date
  end
end
