class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name,        :string
    add_column :users, :address,     :text
    add_column :users, :unit,        :string
    add_column :users, :postal,      :string
    add_column :users, :instruction, :string
    add_column :users, :alternative_contact_number, :string
  end
end
