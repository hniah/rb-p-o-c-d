class CreateLatestUpdates < ActiveRecord::Migration
  def change
    create_table :latest_updates do |t|
      t.string :image
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
