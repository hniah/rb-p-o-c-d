module BookingsHelper
  def booking_time_range

    start_time = Time.zone.now.change(hour: 8, min: 0)
    end_time = Time.zone.now.change(hour: 22, min: 00)
    time_range = []

    begin
      time_range << start_time
    end while (start_time += 30.minutes) < end_time

    time_range
  end

  def display_booked_slot_info(booked_time_slots, day, time, housekeeper_id)
    calendar_time = create_date_time(day, time)
    booked_time_slot = time_slot_used(booked_time_slots, calendar_time)

    if booked_time_slot
      if booked_time_slot.booked? && booked_time_slot.session_contains?(calendar_time)
        render partial: 'bookings/booked_slot'
      end
    elsif total_sessions(booked_time_slots, calendar_time) >= 2

    else
      render partial: 'bookings/available_slot', locals: {day: day, time: time, start_time: create_date_time(day, time),housekeeper_id:housekeeper_id}
    end
  end

  def create_date_time(day, time)
    Time.zone.now.change(
      year: day.year,
      month: day.month,
      day: day.day,
      hour: time.hour,
      min: time.min
    )
  end

  def time_slot_used( time_slots, calendar_time )
    time_slots.find do |time_slot|
      time_slot.session_blocks?(calendar_time)
    end
  end

  def total_sessions(time_slots, date)
    time_slots.select do |time_slot|
      time_slot.start_time.between?(date.beginning_of_day, date.end_of_day)
    end.size
  end

  def to_durations(start_time,end_time)
    TimeDifference.between(start_time, end_time).in_hours.to_i
  end

  def housekeeper_list
    Housekeeper.all
  end

  def durations_list
    [["3 hours", 3], ["4 hours", 4], ["5 hours", 5]]
  end

  def contain_feedback?
    feedbacks = Feedback.all
    feedbacks.find do |feedback|
      feedback.time_slot == self
    end
  end

  def time_in_words_with_zone(time)
    time.strftime("%d-%m-%Y %H:%M:%S %z")
  end

  def time_in_words_with_day(datetime)
    datetime.strftime("%d-%m-%Y %H:%M:%S")
  end

  def time_in_words(datetime)
    datetime.strftime("%H:%M")
  end

  def day_in_words(datetime)
    datetime.strftime("%d-%m-%Y")
  end

  def format_day(day)
    day.strftime("%d-%m-%Y")
  end
end
