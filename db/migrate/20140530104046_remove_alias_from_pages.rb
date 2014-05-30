class RemoveAliasFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :alias
  end
end
