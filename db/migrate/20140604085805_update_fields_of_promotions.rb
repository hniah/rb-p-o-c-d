class UpdateFieldsOfPromotions < ActiveRecord::Migration
  def change
    remove_column :promotions, :name
    remove_column :promotions, :position
    remove_column :promotions, :description

    add_column :promotions, :url, :string
    add_column :promotions, :description, :text
  end
end
