task :notification_service_done => :environment do
  @service = TimeSlot::ServiceDoneService.new
  @service.execute
end
