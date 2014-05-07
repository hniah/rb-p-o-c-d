class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def express_checkout
    package = get_package
    total_amount_in_cents = package.price_cents
    response = EXPRESS_GATEWAY.setup_purchase(total_amount_in_cents,
                                              return_url: success_payment_url,
                                              cancel_return_url: cancel_payment_url,
                                              currency: "SGD",
                                              allow_guest_checkout: true,
                                              items: [{name: "Package", description: "Package description", quantity: 1, amount: total_amount_in_cents}]
    )

    @payment = Payment.new
    if @payment.create_payment!(current_user, package, response.token, request.remote_ip )
      redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
    else
      flash[:alert] = "Fail to create payment!"
      redirect_to buy_package_path
    end
  end

  def success_payment
    payment = Payment.find_by_express_token(params[:token])
    package = Package.find(payment.package_id)
    if payment.purchase_payment!(params[:PayerID])
      current_user.packages << package
      flash[:notice] = "Package bought successfully!"
      redirect_to bookings_path
    end
  end

  def cancel_payment
    payment = Payment.find_by_express_token(params[:token])
    if payment.destroy!
      flash[:alert] = "Transaction destroyed!"
      redirect_to buy_package_path
    end
  end

  def get_package
    package_id = params.require(:user).permit(:package_id)[:package_id]
    Package.find(package_id)
  end
end
