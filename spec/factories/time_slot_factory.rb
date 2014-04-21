FactoryGirl.define do
  factory :time_slot do
    start_time Time.zone.now.change(hour: 10, min: 0)
    end_time Time.zone.now.change(hour: 14, min: 0)
    category    'booked'
    user        { create(:user) }
    housekeeper { create(:housekeeper) }

    trait :with_8_hours_slot do
      end_time    Time.zone.now.change(hour: 18, min: 0)
    end

    trait :with_2_buffer do
      start_time  Time.zone.now.change(hour: 14, min: 0)
      end_time    Time.zone.now.change(hour: 16, min: 0)
      user  nil
      category 'blocked'
    end

    trait :with_block_before_twelve_thirty_hour do
      start_time  Time.zone.now.change(hour: 8, min: 0)
      end_time    Time.zone.now.change(hour: 10, min: 0)
      user  nil
      category 'blocked'
    end
  end
end
