require 'spec_helper'

describe BookingsController do
  describe '#index' do
    let!(:user) { create(:user) }
    let!(:current_week_time_slot) { create(:time_slot) }

    def do_request
      get :index
    end

    before do
      sign_in user
      do_request
    end

    it 'displays the calendar with time slots of the current week' do
      assigns(:time_slots).size.should == 1
      assigns(:time_slots).first.id = current_week_time_slot.id
      render_template :index
    end
  end

  describe "#new" do
    let(:user) { create(:user) }
    let(:start_time) { Time.zone.now.change(hour: 8, min: 30) }

    def do_request
      get :new, day: start_time.day,
          month: start_time.month,
          year: start_time.year,
          hour: start_time.hour,
          minute: start_time.min
    end

    before do
      sign_in user
      do_request
    end

    it "renders :new template" do
      assigns(:time_slot).should_not be_nil
      response.should render_template :new
    end
  end

  describe "#create" do
    let!(:admin) { create(:admin) }
    before { sign_in user }
    before { do_request }

    def do_request
      post :create, time_slot: time_slot_param
    end

    context "params with start time" do
      let(:user) { create(:user, :with_packages) }
      let(:time_slot_param) { attributes_for(:time_slot).merge({duration: 4, remarks: "Ho Chi Minh City"}) }

      it "should create a block of bookings" do
        flash[:notice].should eq "Booking created successfully"
        response.should redirect_to bookings_path
      end
    end

    context "params without start time" do
      let(:time_slot_param) { {Lorem: "Ipsum"} }
      let(:user) { create(:user) }

      it "should not create a block of bookings" do
        flash[:alert].should eq "Failed to create booking: "
        response.should redirect_to bookings_path
      end
    end
  end
end
