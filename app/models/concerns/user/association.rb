module Concerns::User::Association
  extend ActiveSupport::Concern

  included do
    has_many :time_slots
    has_many :payments
    has_and_belongs_to_many :packages, join_table: 'users_packages'
  end
end
