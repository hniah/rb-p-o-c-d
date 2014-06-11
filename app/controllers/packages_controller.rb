class PackagesController < ApplicationController

  def buy_package
    @packages = Package.all_packages_in_array
    @sessions_type_list = Package::SESSION_TYPE_LIST
  end

end
