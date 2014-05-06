class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :package

  def create_payment!(user, package, token, ip_address)
    self.express_token = token
    self.ip_address = ip_address
    self.user = user
    self.package = package
    self.status = 'pending'
    self.save!
  end

  def purchase_payment!(payer_id)
    self.status = 'complete'
    self.express_payer_id = payer_id
    self.save!
  end

  private

  def express_purchase_options
    {
      ip_address: ip_address,
      token: express_token,
      payer_id: express_payer_id,
      currency: 'USD'
    }
  end
end
