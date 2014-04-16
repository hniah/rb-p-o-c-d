FactoryGirl.define do
  factory :package do
    factory :package_12_hours do
      name '4 x 3-hour sessions'
      hours 12
      price_cents 240
    end

    factory :package_16_hours do
      name '4 x 4-hour sessions'
      hours 16
      price_cents 320
    end
  end
end
