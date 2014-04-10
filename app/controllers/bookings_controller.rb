class BookingsController < ApplicationController
  def index
    @time_slots = TimeSlot.all
    @time_slots = @time_slots.created_after (Date.today.beginning_of_week)
    @time_slots = @time_slots.created_before(Date.today.end_of_week)
  end
end
