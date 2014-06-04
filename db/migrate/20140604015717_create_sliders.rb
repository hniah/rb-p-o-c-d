class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :title
      t.string :caption
      t.string :image
      t.string   :published, default: :publish

      t.timestamps
    end
  end
end
