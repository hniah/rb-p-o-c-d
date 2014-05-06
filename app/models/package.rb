class Package < ActiveRecord::Base
  extend Enumerize
  validates_presence_of :session_type, :price
  validates_numericality_of :hours
  validates_numericality_of :price_cents

  has_and_belongs_to_many :users, join_table: 'users_packages'
  has_many :payments

  monetize :price_cents

  SESSION_TYPE_LIST = [3, 4, 5]
  enumerize :session_type, in: SESSION_TYPE_LIST

  def self.all_packages_in_array
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
