FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "anna-#{n}@example.com" }
    password              '123123'
    password_confirmation '123123'
    name                  'Anna'
    address               'Somewhere in Singapore'
    postal                '651234'
    contact_number        '6652-3568'

    trait :with_packages do
      ignore do
        number_of_packages 3
      end

      after :create do |user, evaluator|
        evaluator.number_of_packages.times do
          package = create :package_12_hours
          user.packages << package
        end
      end
    end

    trait :with_time_slots do
      ignore do
        number_of_time_slots 2
      end

      after :create do |user, evaluator|
        i = 0
        evaluator.number_of_time_slots.times do
          i = i + 1
          time_slot = create(:time_slot, start_time: (Time.zone.now + i.days).change(hour: 10, min: 00), end_time: (Time.zone.now + i.days).change(hour: 14, min: 00))
          user.time_slots << time_slot
        end
      end
    end


  end
end
