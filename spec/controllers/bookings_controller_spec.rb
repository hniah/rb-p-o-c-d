require 'spec_helper'

describe BookingsController do
  describe '#index' do
    let!(:current_week_time_slot) { create(:time_slot) }
    let!(:last_week_time_slot)   { create(:time_slot, created_at: 1.week.ago) }

    it 'displays the calendar with time slots of the current week' do
      get :index
      assigns(:time_slots).size.should == 1
      assigns(:time_slots).first.id = current_week_time_slot.id
      render_template :index
    end
  end
end
