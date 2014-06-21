class TimeSlotsController < ApplicationController
  before_filter :authenticate_user!

  include Concerns::TimeSlots::Redirection

  def index
    @locations = Location.all
    @time_slots = TimeSlot.all

    if location_param.present? && location_param != 0
      @location = Location.find(location_param)
      @housekeepers = @location.housekeepers
    else
      @housekeepers = Housekeeper.all
    end

    @week = week
  end

  def new
    @housekeeper = Housekeeper.find(housekeeper_param)
    @time_slot = TimeSlot.new(start_time: start_time_param, housekeeper: @housekeeper)
    render :new
  end

  def create
    @time_slot = TimeSlot.new(time_slot_param)
    @service = TimeSlot::CreationService.new(self)
    @service.execute!(@time_slot, duration_param, current_user)

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to time_slots_path
  end

  def destroy
    @time_slot = TimeSlot.find_by!(id: time_slot_id, user: current_user)
    @service = TimeSlot::DestructionService.new(self)
    @service.execute!(@time_slot)

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Do not allow to access!"
    redirect_to user_info_path
  end

  def edit
    @time_slot = TimeSlot.find_by!(id: time_slot_id, user: current_user)
    @time_slot.duration
    render :edit

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Do not allow to access!"
    redirect_to user_info_path
  end

  def update
    @time_slot = TimeSlot.find_by!(id: time_slot_id, user: current_user)
    @service = TimeSlot::ModificationService.new(self)
    @service.execute!(@time_slot, time_slot_param)

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Do not allow to access!"
    redirect_to user_info_path
  end

  protected
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

  def time_slot_id
    params.require(:id)
  end

  def time_slot_param
    params.require(:time_slot).permit(:start_time, :remarks, :duration, :housekeeper_id)
  end

  def housekeeper_param
    params[:housekeeper].to_i
  end

  def location_param
    params[:location].to_i
  end

  def duration_param
    time_slot_param[:duration].to_i
  end

  def week
    params.fetch(:week, 0).to_i
  end
end
