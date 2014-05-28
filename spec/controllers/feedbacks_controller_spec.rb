require 'spec_helper'

describe FeedbacksController do

  describe "#create" do
    let(:time_slot) { create(:time_slot) }
    before { sign_in user }
    before { do_request }

    def do_request
      post :create, feedback_params
    end

    context "params is valid" do
      let(:user) { time_slot.user }
      let(:housekeeper) { time_slot.housekeeper }
      let(:feedback_params) { { punctuality: "Neutral",
                                communication: "Neutral",
                                time_management: "Neutral",
                                service_quality: "Neutral",
                                areas_for_improvement: "This is test 1",
                                areas_worthy_of_praise: "This is test 2",
                                other_comments: "This is test 3",
                                user_id: user.id,
                                housekeeper_id: housekeeper.id,
                                time_slot_id: time_slot.id
                            } }
      it "should create a feedback" do
        flash[:notice] = "Feedback create successfully"
        response.should redirect_to user_info_path
      end
    end
  end
end
