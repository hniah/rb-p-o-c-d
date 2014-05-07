module Concerns::Payment::Association
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :package
  end
end
