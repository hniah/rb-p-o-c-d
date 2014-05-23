class CreateSpecialHours < ActiveRecord::Migration
  def change
    create_table :special_hours do |t|
      t.references :user
      t.integer :hour
      t.string  :description
      t.timestamps
    end
  end
end
