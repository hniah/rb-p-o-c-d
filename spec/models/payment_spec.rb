require 'spec_helper'

include ActiveMerchant::Billing

describe Payment do
  context 'association' do
    it { should belong_to :user }
    it { should belong_to :package }
  end

  describe '#create_payment!' do
    let(:user) { create(:user) }
    let(:package) { create(:package_12_hours) }
    let(:payment) { build(:payment) }

    it 'should be valid' do
      expect {payment.create_payment!(user,package,'123456789','192.128.1.100')}.to change(Payment, :count).by(1)
      payment.status.should eq 'pending'
    end
  end

  describe '#purchase_payment!' do
    let!(:pending_payment) { create(:payment, :with_pending_status) }
    let(:payer_id) { '2222' }

    it 'should be updated' do
      expect { pending_payment.purchase_payment!(payer_id) }.to change(pending_payment, :status).to('complete')
    end
  end
end
