module UsersHelper
  def refund?(start_time)
    day_check = (start_time - 1.day).change(hour: 18, min: 15)
    Time.zone.now < day_check
  end

  def show_action_button?(start_time)
    Time.zone.now < start_time
  end

  def rating_scale_list
    [["Very Satisfied", "Very Satisfied"],["Satisfied", "Satisfied"], ["Neutral", "Neutral"], ["Dissatisfied", "Dissatisfied"],["Very Dissatisfied", "Very Dissatisfied"]]
  end
end
