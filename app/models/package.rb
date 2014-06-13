class Package < ActiveRecord::Base
  extend Enumerize

  has_and_belongs_to_many :users, join_table: 'payments'
  has_many :payments
  has_many :promotion_codes

  validates_presence_of :session_type, :price, :name
  validates_numericality_of :hours
  validates_numericality_of :price_cents

  monetize :price_cents

  SESSION_TYPE_LIST = [3, 4, 5]
  enumerize :session_type, in: SESSION_TYPE_LIST

  class << self
    def all_packages_in_array
      packages = Package.all
      return_packages = {}

      packages.each do |package|
        SESSION_TYPE_LIST.each do |session_type|
          if package.session_type == session_type.to_s
            unless return_packages[session_type].is_a?(Array)
              return_packages[session_type] = []
            end
            return_packages[session_type] << package
          end
        end
      end

      return_packages
    end
  end
end
