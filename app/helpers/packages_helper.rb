module PackagesHelper
  def show_buy_package_button(package, user)
    if package.price == 0
      " - "
    else
      render partial: 'packages/button', locals: {package: package, user: user}
    end
  end
end
