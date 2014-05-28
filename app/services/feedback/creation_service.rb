class Feedback::CreationService < Struct.new(:listener)

  def execute!(feedback)
    feedback.save!
    listener.create_feedback_successful
  end
end
