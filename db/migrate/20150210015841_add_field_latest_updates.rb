class AddFieldLatestUpdates < ActiveRecord::Migration
  def change
    add_column :latest_updates, :title_link, :string
  end
end
