FactoryGirl.define do
  factory :feedback do
    punctuality "Satisfied"
    communication "Very Satisfied"
    time_management "Satisfied"
    service_quality "Neutral"
    areas_for_improvement "This is areas_for_improvement"
    areas_worthy_of_praise "This is areas_worthy_of_praise"
    other_comments "This is other_comments"

    user { create :user }
    housekeeper { create :housekeeper }
    time_slot { create :time_slot }
  end
end
