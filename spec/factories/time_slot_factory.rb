FactoryGirl.define do
  factory :time_slot do
    start_time  DateTime.now.change(hour: 8, minute: 0)
    end_time    DateTime.now.change(hour: 11, minute: 0)
    category    'booked'
    user        { create(:user) }
    housekeeper { create(:housekeeper) }

    trait :with_8_hours_slot do
      end_time    DateTime.now.change(hour: 16, minute: 0)
    end

    trait :with_2_hours_apart do
      start_time  DateTime.now.change(hour: 11,minute: 0)
      end_time    DateTime.now.change(hour: 13, minute: 0)
    end
  end
end
