class AddAliasToPages < ActiveRecord::Migration
  def change
    add_column :pages, :alias,    :string
  end
end
