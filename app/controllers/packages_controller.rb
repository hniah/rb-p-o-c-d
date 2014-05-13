class PackagesController < ApplicationController
  before_action :authenticate_user!

  def buy_package
    @packages = Package.all_packages_in_array
    @sessions_type_list = Package::SESSION_TYPE_LIST
    render :buy_package
  end
  private

  def get_package
    package_id = params.require(:user).permit(:package_id)[:package_id]
    Package.find(package_id)
  end
end
