class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :session_type
      t.integer :hours
      t.money :price
    end
  end
end
