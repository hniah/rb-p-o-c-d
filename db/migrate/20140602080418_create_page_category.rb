class CreatePageCategory < ActiveRecord::Migration
  def change
    create_table :page_categories do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
