module PackagesHelper
  def show_buy_package_button(package, user, index)

    if package.price == 0
      "<span class='no-price'> - </span>".html_safe
    else
      if index == 1
        render partial: 'packages/button', locals: {package: package, user: user,btn_title: 'I want this',btn_class:'btn-effect btn-3 btn-3c'}
      else
        render partial: 'packages/button', locals: {package: package, user: user,btn_title: 'I need this',btn_class:'btn-effect btn-2 btn-2c'}
      end

    end
  end
end
