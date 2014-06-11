class Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :housekeeper
  belongs_to :time_slot

  validate :only_one

  def only_one
    feedbacks = Feedback.all
    feedbacks.find do |feedback|
      if self.duplicate_by(feedback)
        errors[:base] << "Only one feedback for each booking"
      end
    end
  end

  def duplicate_by(feedback)
    self.time_slot == feedback.time_slot
  end
end
