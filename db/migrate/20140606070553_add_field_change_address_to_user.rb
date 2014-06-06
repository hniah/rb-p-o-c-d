class AddFieldChangeAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :changeable_address, :string, default: "no"
  end
end
