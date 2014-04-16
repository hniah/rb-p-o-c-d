class Package < ActiveRecord::Base
  validates_presence_of :name, :price, :hours
  validates_numericality_of :hours, :price_cents, greater_than: 0

  has_and_belongs_to_many :users, join_table: 'users_packages'

  monetize :price_cents
end
