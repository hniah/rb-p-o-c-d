class User::CreationService < Struct.new(:listener)

  def execute!(promotion_code, user)

    if promotion_code.nil?
      listener.redirect_to_user_new_promotion_path('Promotion code not recognised. Please check if it had been used before or if ‘Caps lock’ was accidentally turned on.') and return
    end

    if promotion_code.used == true
      listener.redirect_to_user_new_promotion_path('Promotion code is used') and return
    end

    payment = Payment.new
    payment.user = user
    payment.package = promotion_code.package
    payment.status = 'complete'
    payment.description = "add promotion code #{promotion_code.code}"
    payment.save!

    promotion_code.used = true
    promotion_code.save!

    listener.add_promotion_code_successful
  end
end
