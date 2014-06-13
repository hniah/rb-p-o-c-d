class CreatePromotionCode < ActiveRecord::Migration
  def change
    create_table :promotion_codes do |t|
      t.string :code
      t.boolean :used, default: false
      t.references :package

      t.timestamps
    end
  end
end
