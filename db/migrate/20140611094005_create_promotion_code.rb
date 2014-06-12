class CreatePromotionCode < ActiveRecord::Migration
  def change
    create_table :promotion_codes do |t|
      t.string :code
      t.boolean :permanent, default: false
      t.integer :hours

      t.timestamps
    end
  end
end
