class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_slots = TimeSlot.all
    @time_slots = @time_slots.created_after (Date.today.beginning_of_week)
    @time_slots = @time_slots.created_before(Date.today.end_of_week)
  end

  def create
    @time_slot = TimeSlot.new(time_slot_param)
    @time_slot.end_time = @time_slot.start_time + 3.hours
    @time_slot.user = current_user
    @time_slot.category = :booked
    @time_slot.save!

    flash[:notice] = "Booking created successfully"
    redirect_to bookings_path
  end

  def time_slot_param
    params.require(:time_slot).permit(:start_time)
  end
end
