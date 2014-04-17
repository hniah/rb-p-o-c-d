module BookingsHelper
  def booking_time_range
    start_time = DateTime.now.change(hour: 8, minute: 00)
    end_time = DateTime.now.change(hour: 22, minute: 00)
    time_range = []

    begin
      time_range << start_time
    end while (start_time += 30.minutes) < end_time

    time_range
  end

  def display_booked_slot_info(booked_time_slots, day, time)
    calendar_time_slot = create_date_time(day, time)
    booked_time_slot = find_booked_time_slot(booked_time_slots, calendar_time_slot)

    if booked_time_slot
      if booked_time_slot.category.booked?
        render partial: 'bookings/booked_slot'
      end
    else
      render partial: 'bookings/available_slot', locals: {day: day, time: time, start_time: create_date_time(day, time)}
    end
  end

  def create_date_time(day, time)
    Time.local(day.year, day.month, day.day, time.hour, time.min)
  end

  def find_booked_time_slot(booked_time_slots, calendar_time_slot)
    booked_time_slots.find do |time_slot|
      calendar_time_slot >= time_slot.start_time && calendar_time_slot < time_slot.end_time
      #calendar_time_slot.between?(time_slot.start_time, time_slot.end_time)
    end
  end
end
