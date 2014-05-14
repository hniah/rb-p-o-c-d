require 'spec_helper'

describe BookingsController do
  describe '#index' do
    let!(:user) { create(:user) }
    let!(:current_week_time_slot) { create(:time_slot) }

    def do_request
      get :index
    end

    context "user is not signed in" do
      before { do_request }

      it { should redirect_to new_user_session_path }
      it { should set_the_flash[:alert] }
    end

    context "signed in user" do
      before { sign_in user }
      before { do_request }

      it { should render_template :index }
      it "should assign time slots" do
        expect(assigns(:time_slots).size).to eq 1
      end

      context "assigned @time_slot" do
        subject { assigns :time_slots }

        it { should include current_week_time_slot }
      end
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
      let(:time_slot_param) { attributes_for(:time_slot).merge({duration: 4,
                                                                remarks: "Ho Chi Minh City"}) }

      it "should create a block of bookings" do
        flash[:notice].should eq "Booking created successfully"
        response.should redirect_to bookings_path
      end
    end

    context "params without start time" do
      let(:time_slot_param) { { Lorem: "Ipsum" } }
      let(:user) { create(:user) }

      it "should not create a block of bookings" do
        flash[:alert].should_not be_empty
        response.should redirect_to bookings_path
      end
    end

    context "time slot is not affordable" do
      let(:time_slot_param) { attributes_for(:time_slot).merge({duration: 4, remarks: "Ho Chi Minh City"}) }
      let(:user) { create(:user) }

      it "should redirect user to buy package page" do
        flash[:alert].should_not be_empty
        response.should redirect_to buy_package_path
      end
    end

    context "time slot is not unbookable" do

      context 'start time should be after 2 hours' do
        let(:time_slot_param) { attributes_for(:time_slot).merge({duration: 4,
                                                                  remarks: "Ho Chi Minh City",
                                                                  start_time: Time.zone.now.change(hour: 10, min: 0)
                                                                 }) }
        let(:user) { create(:user, :with_packages) }

        it "should redirect user to booking page" do
          flash[:alert].should_not be_empty
          response.should redirect_to bookings_path
        end
      end

      context 'end time should be between 3 - 5 hours' do
        let(:time_slot_param) { attributes_for(:time_slot).merge({duration: 1,
                                                                  remarks: "Ho Chi Minh City",
                                                                  start_time: time_with_zone(hour: 10, min: 0),
                                                                  end_time: time_with_zone(hour: 11, min: 0),
                                                                 }) }
        let(:user) { create(:user, :with_packages) }

        it "should redirect user to booking page" do
          flash[:alert].should_not be_empty
          response.should redirect_to bookings_path
        end
      end
    end
  end

  describe '#destroy' do
    let!(:admin) { create(:admin) }
    let(:time_slot) { create(:time_slot) }
    let(:id)  { time_slot.id }

    before { sign_in user }
    before { do_request }

    def do_request
      delete :destroy, id: id
    end

    context 'user is the creator time slot' do
      let(:user) { time_slot.user }

      it 'should be destroyed' do
        flash[:notice].should eq "Booking is destroyed successfully"
        expect { TimeSlot.find(id) }.to raise_error
        response.should redirect_to user_info_path
      end
    end

    context 'user is not the creator time slot' do
      let(:user) { create :user }

      it 'should be redirect to user info page' do
        response.should redirect_to user_info_path
      end
    end
  end

  describe '#edit' do
    let!(:admin) { create(:admin) }

    let(:time_slot) { create(:time_slot) }
    let(:id) { time_slot.id }

    before { sign_in user }
    before { do_request }

    def do_request
      get :edit, id: id
    end

    context "user is the creator of the time slot" do
      let(:user) { time_slot.user }

      it 'should be display edit booking layout' do
        response.should render_template :edit
      end
    end

    context "user is not the creator of the time slot" do
      let(:user) { create :user }

      it 'should be redirect to user info page' do
        response.should redirect_to user_info_path
      end
    end
  end

  describe '#update' do
    let!(:admin) { create(:admin) }

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

    context "user is the creator of the time slot" do
      let(:user) { time_slot.user }

      it 'should be redirect to booking schedule' do
        flash[:notice].should eq "Update booking successfully"
        response.should redirect_to user_info_path
      end
    end

    context "user is not the creator of the time slot" do
      let(:user) { create(:user) }

      it 'does not allow user to update' do
        flash[:alert].should_not be_nil
        response.should redirect_to user_info_path
      end
    end
  end
end
