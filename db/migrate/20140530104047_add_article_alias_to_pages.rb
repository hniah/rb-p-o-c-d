class AddArticleAliasToPages < ActiveRecord::Migration
  def change
    add_column :pages, :article_alias, :string
  end
end
