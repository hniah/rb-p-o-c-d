module Concerns::Page::Validation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :article_alias, :description
    validates_uniqueness_of :article_alias
  end
end
