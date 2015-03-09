module Concerns::TimeSlots::Redirection
  extend ActiveSupport::Concern

  included do
    def redirect_to_buy_package(message)
      flash[:alert] = message
      redirect_to buy_package_path
    end

    def redirect_to_bookings_path(message)
      flash[:alert] = message
      redirect_to time_slots_path
    end

    def redirect_to_user_info_path(message)
      flash[:alert] = message
      redirect_to user_info_path
    end

    def create_time_slot_successful
      flash[:notice] = 'You have booked a session successfully.'
      redirect_to time_slots_path
    end

    def update_time_slot_successful
      flash[:notice] = 'Your booking has been updated successfully.'
      redirect_to user_info_path
    end

    def destroy_time_slot_successful
      flash[:notice] = 'Your booking has been cancelled successfully. To make a new booking, please contact us.'
      redirect_to user_info_path
    end
  end
end
