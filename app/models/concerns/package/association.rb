module Concerns::Package::Association
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :users, join_table: 'payments'
    has_many :payments
  end
end
