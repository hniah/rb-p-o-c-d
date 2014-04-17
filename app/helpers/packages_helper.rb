module PackagesHelper
  def show_buy_package_button(package, user)
    html = ""
    if package.price == 0
      html += "-"
    else
      html += simple_form_for user, as: :user, url: buy_package_path, method: :patch do |f|
        form_html = ""
        form_html += f.input :package_id, as: :hidden, input_html: { value: package.id }
        form_html += f.submit number_to_currency(package.price, precision: 0), class: 'btn', data: { test: package.id }
        form_html.html_safe
      end
    end
    html
  end
end
