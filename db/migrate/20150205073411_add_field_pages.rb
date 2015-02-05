class AddFieldPages < ActiveRecord::Migration
  def change
    add_column :pages, :full_image, :string
  end
end
