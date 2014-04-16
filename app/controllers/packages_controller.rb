class PackagesController < ApplicationController
  before_action :authenticate_user!

  def buy_package
    @packages = Package.all
    render :buy_package
  end

  def do_buy_package
    package = get_package
    current_user.packages << package
    flash[:notice] = "Package bought successfully"
    redirect_to bookings_path
  end

  def get_package
    package_id = params.require(:user).permit(:package_id)[:package_id]
    Package.find(package_id)
  end
end
