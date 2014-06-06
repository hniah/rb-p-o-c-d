class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :block, :string , default: :unblock
  end
end
