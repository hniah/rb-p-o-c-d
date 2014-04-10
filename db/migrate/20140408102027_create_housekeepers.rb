class CreateHousekeepers < ActiveRecord::Migration
  def change
    create_table :housekeepers do |t|
      t.string :name
      t.string :gender
      t.string :email
      t.string :contact
      t.text   :address
      t.string :postal
      t.date   :date_of_birth
    end
  end
end
