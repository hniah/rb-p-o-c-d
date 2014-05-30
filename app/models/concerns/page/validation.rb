module Concerns::Page::Validation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :alias, :description
  end
end
