module UsersHelper
  def refund?(start_time)
    day_check = (start_time - 1.day).change(hour: 18, min: 15)
    Time.zone.now < day_check
  end
end
