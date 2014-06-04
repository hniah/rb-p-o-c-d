class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :image
      t.string :position
      t.string :description

      t.timestamps
    end
  end
end
