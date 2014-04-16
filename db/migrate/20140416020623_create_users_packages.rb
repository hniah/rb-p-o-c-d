class CreateUsersPackages < ActiveRecord::Migration
  def change
    create_table :users_packages do |t|
      t.references :user
      t.references :package
      t.timestamps
    end
  end
end
