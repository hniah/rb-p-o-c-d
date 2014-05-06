FactoryGirl.define do
  factory :payment do
    ip_address '192.168.1.1'
    express_token '123456789'
    express_payer_id '1111'

    trait :with_pending_status do
      status 'pending'
      user { create(:user) }
      package { create(:package_12_hours) }
    end
  end
end
