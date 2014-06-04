class CreateContactForm < ActiveRecord::Migration
  def change
    create_table :contact_forms do |t|
      t.string :name
      t.string :email
      t.string :message
      t.string :contact

      t.timestamps
    end
  end
end
