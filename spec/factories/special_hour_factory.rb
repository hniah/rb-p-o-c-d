FactoryGirl.define do
  factory :special_hour do
    hour 2
    user { create(:user) }
    description 'this is special hour'
  end
end
