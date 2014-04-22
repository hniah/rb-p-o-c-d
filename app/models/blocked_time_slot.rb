class BlockedTimeSlot < ActiveRecord::Base
  extend Enumerize

  validates_presence_of :start_time, :end_time, :category
  belongs_to :time_slot

  enumerize :category, in: [:blocked, :unblocked]

  def self.create_blocked_time_slots!(time_slot)
    return false unless time_slot.start_time.is_a?(ActiveSupport::TimeWithZone)

    start_time = time_slot.start_time.hour * 60 + time_slot.start_time.min
    end_time = time_slot.end_time.hour * 60 + time_slot.end_time.min

    if start_time >= 8 * 60 && start_time <= 12 * 60 + 30
      if start_time != 8 * 60
        BlockedTimeSlot.new(
          start_time: time_slot.start_time.change(hour: 8, min: 0),
          end_time: time_slot.start_time,
          category: :blocked,
          time_slot: time_slot
        ).save!
      end

      BlockedTimeSlot.new.create_blocked_2_hours(time_slot,'after')

    elsif end_time >= 14*60 + 30 && end_time <= 19*60 && end_time > start_time + 3*60
      BlockedTimeSlot.new.create_blocked_2_hours(time_slot,'before')
      BlockedTimeSlot.new(
        start_time: time_slot.end_time,
        end_time: time_slot.end_time.change(hour: 22,min: 0),
        category: :blocked,
        time_slot: time_slot
      ).save!

    else
      BlockedTimeSlot.new.create_blocked_2_hours(time_slot,'before')
      BlockedTimeSlot.new.create_blocked_2_hours(time_slot,'after')
    end
  end

  def create_blocked_2_hours(time_slot,buffer_position)
    if buffer_position == 'before'
      self.start_time = time_slot.start_time - 2.hours
      self.end_time = time_slot.start_time
    end

    if buffer_position == 'after'
      self.start_time = time_slot.end_time
      self.end_time   = time_slot.end_time + 2.hours
    end
    self.time_slot = time_slot
    self.category = :blocked
    self.save
  end
end
