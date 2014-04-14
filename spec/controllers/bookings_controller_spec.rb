require 'spec_helper'

describe BookingsController do
  describe '#index' do
    let!(:user) { create(:user) }
    let!(:current_week_time_slot) { create(:time_slot) }
    let!(:last_week_time_slot)   { create(:time_slot, created_at: 1.week.ago) }

    it 'displays the calendar with time slots of the current week' do
      sign_in user
      get :index
      assigns(:time_slots).size.should == 1
      assigns(:time_slots).first.id = current_week_time_slot.id
      render_template :index
    end
  end

  describe "#new" do
    let(:user) { create :user }

    it "renders :new template" do
      sign_in user
      get :new, time_slot: { start_time: DateTime.now.change(hour: 10, minute: 00) }
      assigns(:time_slot).should_not be_nil
      response.should render_template :new
    end
  end

  describe "#create" do
    let(:user) { create(:user) }

    it "should create a block of bookings" do
      sign_in user
      expect do
        post :create, time_slot: attributes_for(:time_slot)
      end.to change(TimeSlot, :count).by(1)

      flash[:notice].should eq "Booking created successfully"
      response.should redirect_to bookings_path
    end
  end
end
