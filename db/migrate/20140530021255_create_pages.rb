class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :intro_text
      t.string :intro_image
      t.string :description

      t.timestamps
    end
  end
end
