FactoryGirl.define do
  factory :housekeeper do
    name          'Anna'
    gender        'female'
    email         'anna@example.com'
    contact       '6652-3568'
    address       '9 Jurong Town Hall Road #01-25'
    postal        '609431'
    date_of_birth 20.years.ago
  end
end
