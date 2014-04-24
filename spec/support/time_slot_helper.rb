module TimeSlotHelper

  def create_time_slot(start_time = {hour: 8, min: 0}, duration = 3)
    create(:time_slot,
          start_time: time_with_zone(start_time),
          end_time: time_with_zone(start_time) + duration.hours
          )
  end

  def build_time_slot(start_time = {hour: 8, min: 0}, duration = 3)
    build(:time_slot,
           start_time: time_with_zone(start_time),
           end_time: time_with_zone(start_time) + duration.hours
    )
  end
end
