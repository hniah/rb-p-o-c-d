class RemoveEmailToHousekeepers < ActiveRecord::Migration
  def change
    remove_column :housekeepers, :email
  end
end
