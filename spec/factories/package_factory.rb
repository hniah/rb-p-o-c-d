FactoryGirl.define do
  factory :package do
    factory :package_12_hours do
      session_type 3
      hours 12
      price_cents 240
    end

    factory :package_16_hours do
      session_type 4
      hours 16
      price_cents 320
    end
  end
end
