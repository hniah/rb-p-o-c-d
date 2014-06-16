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

  def how_did_you_hear_about_us_list
    [["Social Network", "Social Network"],["Search engines", "Search engines"], ["Forums or Blogs", "Forums or Blogs"], ["Email ", "Email "],["Print ads (i.e., Newspapers, magazines)", "Print ads (i.e., Newspapers, magazines)"], ["Flyers ", "Flyers "], ["Events ", "Events "], ["Word-of-mouth ", "Word-of-mouth "], ["Others","Others"]]
  end
end
