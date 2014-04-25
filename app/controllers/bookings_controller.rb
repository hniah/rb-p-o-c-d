class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_slots = TimeSlot.all
    @time_slots = @time_slots.created_after (Time.zone.now.beginning_of_week)
    @time_slots = @time_slots.created_before(Time.zone.now.end_of_week)
  end

  def new
    @time_slot = TimeSlot.new(start_time: start_time_param)
    render :new
  end

  def create
    @time_slot = TimeSlot.new(time_slot_param)

    if @time_slot.create_booking_by(current_user, duration_param)
      flash[:notice] = "Booking created successfully"
    else
      flash[:alert] = "Failed to create booking: #{@time_slot.errors.full_messages.first}"
    end
     redirect_to bookings_path
  end

  private
  def start_time_param
    start_time = params.permit(:day, :month, :year, :hour, :minute)

    Time.zone.now.change(
      day: start_time[:day],
      month: start_time[:month],
      year: start_time[:year],
      hour: start_time[:hour],
      min: start_time[:minute]
    )
  end

  def time_slot_param
    params.require(:time_slot).permit(:start_time, :remarks, :duration)
  end

  def duration_param
    time_slot_param[:duration].to_i
  end
end
