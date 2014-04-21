class TimeSlot < ActiveRecord::Base
  extend Enumerize

  attr_accessor :duration

  belongs_to :user
  belongs_to :housekeeper

  enumerize :category, in: [:booked, :blocked]

  validates_presence_of :start_time, :end_time, :category
  validate :time_is_between_3_to_5_hours, if: :has_start_and_end_time? && :booked?
  validate :bookable?

  scope :created_after,  -> (date) { where('created_at >= ?', date) }
  scope :created_before, -> (date) { where('created_at <= ?', date) }

  def time_is_between_3_to_5_hours
    duration = TimeDifference.between(start_time, end_time).in_hours
    if duration < 3 || duration > 5
      errors.add(:end_time, 'must be at between 3 to 5 hours from start time')
    end
  end

  def bookable?
    time_slots = TimeSlot.all
    time_slots.each do |time_slot|
      blocked_start_time = time_slot.start_time - 2.hours
      blocked_end_time = time_slot.end_time + 2.hours

      if self.start_time.between?(blocked_start_time, blocked_end_time)
        errors.add(:start_time, 'overlaps another time slot')
      end

      if self.end_time.between?(blocked_start_time, blocked_end_time)
        errors.add(:end_time, 'overlaps another time slot')
      end
    end
  end

  def booked?
    self.category == 'booked'
  end

  def has_start_and_end_time?
    self.start_time.present? && self.end_time.present?
  end

  def create_booking_by!(user, duration = 3)
    return false unless self.start_time.is_a?(ActiveSupport::TimeWithZone)
    self.end_time = self.start_time + duration.hours
    self.user = user
    self.category = :booked
    self.save!
  end

  def create_blocked_time_slot!(time_slot)
    return false unless time_slot.start_time.is_a?(ActiveSupport::TimeWithZone)

    eight_hour              = Time.zone.now.change(hour: 8, minute: 0)
    twelve_thirty_hour      = Time.zone.now.change(hour: 12, minute: 30)

    thirteen_hour           = Time.zone.now.change(hour: 13, minute: 00)
    fourteen_hour           = Time.zone.now.change(hour: 14, minute: 00)

    fourteen_thirty_hour    = Time.zone.now.change(hour: 14, minute: 30)
    nineteen_hour           = Time.zone.now.change(hour: 19, minute: 00)

    twenty_two_hour         = Time.zone.now.change(hour: 22, minute: 00)

    if time_slot.start_time.between?(eight_hour,twelve_thirty_hour)
      if time_slot.start_time != eight_hour
        self.start_time = eight_hour
        self.end_time = time_slot.start_time
        self.user = nil
        self.housekeeper = nil
        self.category = :blocked
        if self.save!
          TimeSlot.new.create_2_hour_buffer!(time_slot,'after')
        end
      else
        TimeSlot.new.create_2_hour_buffer!(time_slot,'after')
      end
    end

    if time_slot.start_time.between?(fourteen_thirty_hour,nineteen_hour)
      self.start_time = time_slot.end_time
      self.end_time = twenty_two_hour
      self.user nil
      self.category = :blocked
      if self.save!
        TimeSlot.new.create_2_hour_buffer!(time_slot, 'before')
      end
    end

    if time_slot.start_time.between?(thirteen_hour,fourteen_hour)
      self.user = nil
      self.category = :blocked
      if self.save!
        TimeSlot.new.create_2_hour_buffer!(time_slot,'after')
        TimeSlot.new.create_2_hour_buffer!(time_slot,'before')
      end
    end
  end

  def create_2_hour_buffer!(time_slot,buffer_position)
    #return false unless time_slot.start_time.is_a?(ActiveSupport::TimeWithZone)
    if buffer_position == 'before'
      self.start_time = time_slot.start_time - 2.hours
      self.end_time = time_slot.start_time
    end

    if buffer_position == 'after'
      self.start_time = time_slot.end_time
      self.end_time   = time_slot.end_time + 2.hours
    end

    self.user = nil
    self.housekeeper = nil
    self.category = :blocked
    self.save!
  end
end
