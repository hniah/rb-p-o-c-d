class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_slots = TimeSlot.all
    @time_slots = @time_slots.created_after (Date.today.beginning_of_week)
    @time_slots = @time_slots.created_before(Date.today.end_of_week)
  end

  def new
    start_time = Time.now.change(
      day: start_time_param[:day],
      month: start_time_param[:month],
      year: start_time_param[:year],
      hour: start_time_param[:hour],
      minute: start_time_param[:minute]
    )

    @time_slot = TimeSlot.new(start_time: start_time)
    render :new
  end

  def create
    @time_slot = TimeSlot.new(time_slot_param)
    duration = time_slot_param[:duration].to_i

    if @time_slot.create_booking_by!(current_user, duration)
      flash[:notice] = "Booking created successfully"
    else
      flash[:alert] = "Failed to create booking"
    end

    redirect_to bookings_path
  end

  def start_time_param
    params.permit(:day, :month, :year, :hour, :minute)
  end

  def time_slot_param
    params.require(:time_slot).permit(:start_time, :remarks, :duration)
  end
end
