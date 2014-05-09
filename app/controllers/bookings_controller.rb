class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_slots = TimeSlot.all
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
    if @time_slot.errors.full_messages.first == 'Time slot : insufficient hours (credit) in account. Please buy packages to booking.'
      redirect_to buy_package_path
    else
      redirect_to bookings_path
    end
  end

  def destroy
    @time_slot = TimeSlot.find(params[:id])

    if @time_slot.destroy_booking
      flash[:notice] = "Booking is destroyed successfully"
    end

    redirect_to user_info_path
  end

  def edit
    @time_slot = TimeSlot.find(params[:id])
    @time_slot.duration
    render :edit
  end

  def update
    @time_slot = TimeSlot.find(params[:id])
    if @time_slot.updated(params[:time_slot])
      flash[:notice] = "Update booking successfully"
    else
      flash[:alert] = "Failed to update booking: #{@time_slot.errors.full_messages.first}"
    end
    redirect_to user_info_path
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
