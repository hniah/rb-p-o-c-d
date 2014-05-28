module Concerns::Feedback::Validation
  extend ActiveSupport::Concern

  included do
    validate :only_one
  end

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
