FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "anna-#{n}@example.com" }
    password              '123123'
    password_confirmation '123123'
    name                  'Anna'
    address               'Somewhere in Singapore'
    postal                '651234'
    contact_number        '6652-3568'
  end
end
