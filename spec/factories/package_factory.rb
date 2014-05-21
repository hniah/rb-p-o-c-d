FactoryGirl.define do
  factory :package do
    sequence(:name) { |n| "#{n} hours" }
    session_type 3
    sequence(:hours) { |n| n * 10 + 10 }
    sequence(:price) { |n| n * 100 + 100 }

    factory :package_12_hours do
      name '3x4 hours'
      session_type 3
      hours 12
      price 24000
    end

    factory :package_16_hours do
      name '4x4 hours'
      session_type 4
      hours 16
      price 32000
    end
  end
end
