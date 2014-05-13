class Payment < ActiveRecord::Base
  include Concerns::Payment::Association

  def purchase!(payer_id)
    self.update!(status: 'complete', express_payer_id: payer_id)
    self.user.packages << self.package
  end
end
