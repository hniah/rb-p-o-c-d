require 'spec_helper'

include ActiveMerchant::Billing

describe Payment do
  context 'association' do
    it { should belong_to :user }
    it { should belong_to :package }
  end

  describe '#purchase_payment!' do
    let!(:payment) { create(:payment, :with_pending_status) }
    let(:payer_id) { '2222' }
    let(:user) { payment.user }

    it 'should be updated' do
      expect { payment.purchase!(payer_id) }.to change(payment, :status).to('complete')
      expect(user.packages).to include(payment.package)
    end
  end
end
