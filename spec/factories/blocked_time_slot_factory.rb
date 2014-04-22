FactoryGirl.define do
  factory :blocked_time_slot do
    start_time  Time.zone.now.change(hour: 14, min: 00)
    end_time    Time.zone.now.change(hour: 16, min: 00)
    category 'blocked'

    after(:create) do |instance|
      create(:time_slot,
            start_time: (Time.zone.now + instance.id.days).change(hour: 12, min: 0),
            end_time: (Time.zone.now + instance.id.days).change(hour: 15, min: 0) )
    end
  end
end
