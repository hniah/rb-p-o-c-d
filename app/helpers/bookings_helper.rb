module BookingsHelper
  def booking_time_range
    start_time = Time.local(2013, 5, 25, 7, 30)
    end_time = Time.local(2013, 5, 25, 22, 30)
    time_range = []

    while (start_time += 1800) < end_time
      time_range << start_time
    end

    time_range
  end
end
