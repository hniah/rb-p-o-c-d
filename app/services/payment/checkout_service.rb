class Payment::CheckoutService
  attr_accessor :package
  attr_accessor :user
  attr_accessor :payment

  def initialize(package, user, payment_params)
    @package, @user = package, user
    @payment = Payment.new(payment_params.merge(user: user, package: package))
  end

  def execute!
    @payment.save!
  end
end
