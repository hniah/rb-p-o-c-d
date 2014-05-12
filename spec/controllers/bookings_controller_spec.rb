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

  describe '#destroy' do
    let!(:admin) { create(:admin) }
    let(:user) { create(:user) }
    let(:time_slot) { create(:time_slot) }
    let(:id)  { time_slot.id }

    before { sign_in user }
    before { do_request }

    def do_request
      delete :destroy, id: id
    end

    it 'should be destroyed' do
      flash[:notice].should eq "Booking is destroyed successfully"
      expect { TimeSlot.find(id) }.to raise_error
      response.should redirect_to user_info_path
    end
  end

  describe '#edit' do
    let!(:admin) { create(:admin) }
    let(:user) { create(:user) }
    let(:time_slot) { create(:time_slot) }
    let(:id) { time_slot.id }

    before { sign_in user }
    before { do_request }

    def do_request
      get :edit, id: id
    end

    it 'should be display edit booking layout' do
      response.should render_template :edit
    end
  end

  describe '#update' do
    let!(:admin) { create(:admin) }
    let(:user) { create(:user) }
    let(:time_slot) { create(:time_slot) }
    let(:id) { time_slot.id }
    let(:params) { {duration: "4",
                    remarks: 'This is test',
                    start_time: Time.zone.now.tomorrow.change(hour: 11, min: 00)} }

    before { sign_in user }
    before { do_request }

    def do_request
      patch :update, id: id, time_slot: params
    end

    it 'should be redirect to booking schedule' do
      flash[:notice].should eq "Update booking successfully"
      response.should redirect_to user_info_path
    end
  end
end
