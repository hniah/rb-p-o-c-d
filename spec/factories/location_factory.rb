FactoryGirl.define do
  factory :location do
    name 'East'

    trait :West do
      name 'West'
    end
  end
end
