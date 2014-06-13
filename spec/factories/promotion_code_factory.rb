FactoryGirl.define do
  factory :promotion_code do
    code '123ABC'
    package { create( :package_12_hours ) }
    used false
  end
end
