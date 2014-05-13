class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def express_checkout
    package = selected_package
    response = create_response(package)
    service = Payment::CheckoutService.new(selected_package, current_user, payment_params.merge(express_token: response.token))
    service.execute!
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)

  rescue Exception
    flash[:alert] = "Fail to create payment!"
    redirect_to buy_package_path
  end

  def success_payment
    payment = Payment.find_by_express_token(express_token)
    payment.purchase!(payer_id)

  rescue Exception => e
    flash[:alert] = e.message

  ensure
    flash[:notice] = "Package bought successfully!"
    redirect_to bookings_path
  end

  def cancel_payment
    payment = Payment.find_by_express_token(express_token)
    if payment.destroy!
      flash[:alert] = "Transaction destroyed!"
      redirect_to buy_package_path
    end
  end

  protected

  def selected_package
    package_id = params.require(:user).permit(:package_id)[:package_id]
    Package.find(package_id)
  end

  def payment_params
    { ip_address: request.remote_ip }
  end

  def create_response(package)
    EXPRESS_GATEWAY.setup_purchase(package.price_cents,
       return_url: success_payment_url,
       cancel_return_url: cancel_payment_url,
       currency: "SGD",
       allow_guest_checkout: true,
       items: [
         {
           name: package.id,
           description: package.id,
           quantity: 1,
           amount: package.price_cents
         }
       ]
    )
  end

  def express_token
    params.require(:token)
  end

  def payer_id
    params.require(:PayerID)
  end
end
