class AddFieldToPages < ActiveRecord::Migration
  def change
    add_column :pages, :short_description, :text
    add_column :pages, :page_category_id, :integer
  end
end
