FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "anna-#{n}@example.com" }
    password              '123123'
    password_confirmation '123123'
    name                  'Anna'
    address               'Somewhere in Singapore'
    postal                '651234'
    contact_number        '6652-3568'
    alternative_contact_number '6652-3578'
    confirmed_at          7.days.ago
    block                 "unblock"
    changeable_address    "no"

    trait :with_payments do
      ignore do
        number_of_payments 3
      end

      after :create do |user, evaluator|
        evaluator.number_of_payments.times do
          payment = create :payment, :with_12_hours
          user.payments << payment
        end
      end
    end

    trait :with_time_slots do
      ignore do
        number_of_time_slots 2
      end

      after :create do |user, evaluator|
        evaluator.number_of_time_slots.times do |n|
          time_slot = create(:time_slot, start_time: (Time.zone.now.tomorrow + (n + 1).days).change(hour: 10, min: 00), end_time: (Time.zone.now.tomorrow + (n + 1).days).change(hour: 14, min: 00))
          user.time_slots << time_slot
        end
      end
    end
  end
end
