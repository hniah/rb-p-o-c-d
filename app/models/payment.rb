class Payment < ActiveRecord::Base
  include Concerns::Payment::Association
  include Concerns::Payment

  def purchase!(payer_id)
    self.update!(status: 'complete', express_payer_id: payer_id)
    self.user.packages << self.package
  end
end
