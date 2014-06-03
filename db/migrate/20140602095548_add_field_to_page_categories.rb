class AddFieldToPageCategories < ActiveRecord::Migration
  def change
    add_column :page_categories, :page_category_alias, :string
  end
end
