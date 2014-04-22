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

  def display_booked_slot_info(booked_time_slots, blocked_time_slots, day, time)
    calendar_time_slot = create_date_time(day, time)
    booked_time_slot = find_booked_time_slot(booked_time_slots, calendar_time_slot)
    blocked_time_slot = find_blocked_time_slot(blocked_time_slots, calendar_time_slot)

    if booked_time_slot
      render partial: 'bookings/booked_slot'
    elsif blocked_time_slot

    else
      render partial: 'bookings/available_slot', locals: {day: day, time: time, start_time: create_date_time(day, time)}
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

  def find_booked_time_slot(booked_time_slots, calendar_time_slot)
    booked_time_slots.find do |time_slot|
      calendar_time_slot >= time_slot.start_time && calendar_time_slot < time_slot.end_time
    end
  end

  def find_blocked_time_slot(blocked_time_slots, calendar_time_slot)
    blocked_time_slots.find do |blocked_time_slot|
      calendar_time_slot >= blocked_time_slot.start_time && calendar_time_slot < blocked_time_slot.end_time
    end
  end
end
