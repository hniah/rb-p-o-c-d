class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_slots = TimeSlot.all
    @time_slots = @time_slots.created_after (Date.today.beginning_of_week)
    @time_slots = @time_slots.created_before(Date.today.end_of_week)
  end

  def new
    @time_slot = TimeSlot.new(time_slot_param)
    render :new
  end

  def create
    @time_slot = TimeSlot.new(time_slot_param)

    if @time_slot.create_booking_by!(current_user)
      flash[:notice] = "Booking created successfully"
    else
      flash[:alert] = "Failed to create booking"
    end

    redirect_to bookings_path
  end

  def time_slot_param
    params.require(:time_slot).permit(:start_time)
  end
end
