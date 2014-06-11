class Payment < ActiveRecord::Base
  include Concerns::RailsAdmin::Payment

  belongs_to :user
  belongs_to :package

  def purchase!(payer_id)
    self.update!(status: 'complete', express_payer_id: payer_id)
    self.user.packages << self.package
  end
end
