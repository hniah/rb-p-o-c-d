class Payment < ActiveRecord::Base
  include Concerns::Payment::Association

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
end
