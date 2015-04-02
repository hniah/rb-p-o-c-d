class PaymentsController < ApplicationController
  before_action :store_location
  before_action :authenticate_user!

  def store_location
    store_location_for(:user, buy_package_path)
  end

  def express_checkout
    package = selected_package
    response = create_response(package)
    service = Payment::CheckoutService.new(selected_package, current_user, payment_params.merge(express_token: response.token))
    service.execute!
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)

  rescue Exception
    flash[:alert] = 'Payment was unsuccessful. Please contact us for clarification.'
    redirect_to buy_package_path
  end

  def success_payment
    package = Package.find(package_id)
    details = EXPRESS_GATEWAY.details_for(express_token)
    response = EXPRESS_GATEWAY.purchase(package.price_cents,
                                        return_url: success_payment_url(id: package.id),
                                        cancel_return_url: cancel_payment_url,
                                        currency: "SGD",
                                        allow_guest_checkout: true,
                                        items: [
                                          {
                                            name: package.name,
                                            quantity: 1,
                                            amount: package.price_cents
                                          }
                                        ],
                                        ip_address:   request.remote_ip,
                                        token:        express_token,
                                        payer_id:    details.payer_id
    )

    if response.success?
      payment = Payment.find_by_express_token(express_token)
      payment.purchase!(payer_id)
    else
      flash[:error] = 'Your transaction could not be completed. Please contact us for assistance. Thank you.'
      redirect_to buy_package_path
    end

  rescue Exception => e
    flash[:alert] = e.message

  ensure
    flash[:notice] = 'Thank you for your purchase. Please contact us to book your cleaning session(s).'
    redirect_to new_contact_form_path
  end

  def cancel_payment
    payment = Payment.find_by_express_token(express_token)
    if payment.destroy!
      flash[:alert] = 'Your transaction has been cancelled.'
      redirect_to buy_package_path
    end
  end

  protected

  def selected_package
    package_id = params.permit(:package_id)[:package_id]
    Package.find(package_id)
  end

  def payment_params
    { ip_address: request.remote_ip }
  end

  def create_response(package)
    EXPRESS_GATEWAY.setup_purchase(package.price_cents,
      ip_address: request.remote_ip,
      return_url: success_payment_url(id: package.id),
      cancel_return_url: cancel_payment_url,
      currency: "SGD",
      allow_guest_checkout: true,
      items: [
         {
           name: package.name,
           quantity: 1,
           amount: package.price_cents
         }
      ]
    )
  end

  def express_token
    params.require(:token)
  end

  def package_id
    params.require(:id)
  end

  def payer_id
    params.require(:PayerID)
  end
end
