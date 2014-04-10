FactoryGirl.define do
  factory :time_slot do
    start_time  DateTime.now
    end_time    3.hours.from_now
    category    :booking
    user        { create(:user) }
    housekeeper { create(:housekeeper) }
  end
end
