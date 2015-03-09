class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def create
    @feedback = Feedback.new(feedback_params)
    @service = Feedback::CreationService.new(self)
    @service.execute!(@feedback)

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to user_info_path
  end

  def create_feedback_successful
    flash[:notice] = 'Thank you for your valuable feedback!'
    redirect_to user_info_path
  end

  protected
  def feedback_params
    params.permit(:punctuality,
                  :communication,
                  :time_management,
                  :service_quality,
                  :areas_for_improvement,
                  :areas_worthy_of_praise,
                  :other_comments,
                  :user_id,
                  :housekeeper_id,
                  :time_slot_id
    )
  end
end
