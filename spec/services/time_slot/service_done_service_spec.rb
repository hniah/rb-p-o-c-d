require 'spec_helper'

describe TimeSlot::ServiceDoneService do
  describe "#execute" do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:service) { TimeSlot::ServiceDoneService.new }
    let(:housekeeper) { create(:housekeeper) }
    let(:housekeeper2) { create(:housekeeper) }

    context 'first service done' do
      context 'success' do
        let!(:time_slot) { create(:time_slot,
                                  start_time: Time.zone.now.change(hour: 8, min: 0),
                                  end_time: Time.zone.now.change(hour: 11, min: 0),
                                  user: user
        ) }

        let!(:time_slot2) { create(:time_slot,
                                  start_time: Time.zone.now.change(hour: 8, min: 0),
                                  end_time: Time.zone.now.change(hour: 11, min: 0),
                                  user: user2,
                                  housekeeper: housekeeper2
        ) }

        it 'should send an email to user' do
          expect(TimeSlot::ServiceDoneMailer).to receive(:send_notification_to_user).exactly(2).times
          service.execute
        end
      end

      context 'failure' do
        let!(:time_slot) { create(:time_slot,
                                  start_time: Time.zone.now.change(hour: 8, min: 0),
                                  end_time: Time.zone.now.change(hour: 11, min: 0),
                                  user: user
        ) }
        let!(:time_slot2) { create(:time_slot,
                                  start_time: time_with_zone(hour: 8, min: 0) - 1.day,
                                  end_time: time_with_zone(hour: 11, min: 0) - 1.day,
                                  user: user
        ) }

        it 'should send an email to user' do
          expect(TimeSlot::ServiceDoneMailer).to receive(:send_notification_to_user).exactly(0).times
          service.execute
        end
      end
    end

    context '4th service done' do
      before do
        create(:time_slot,
          start_time: Time.zone.now.change(hour: 8, min: 0),
          end_time: Time.zone.now.change(hour: 11, min: 0),
          user: user
        )
        create(:time_slot,
         start_time: time_with_zone(hour: 8, min: 0) - 1.week,
         end_time: time_with_zone(hour: 11, min: 0) - 1.week,
         user: user
        )
        create(:time_slot,
         start_time: time_with_zone(hour: 16, min: 0) - 1.week,
         end_time: time_with_zone(hour: 19, min: 0) - 1.week,
         user: user
        )
        create(:time_slot,
         start_time: time_with_zone(hour: 8, min: 0) - 2.week,
         end_time: time_with_zone(hour: 11, min: 0) - 2.week,
         user: user
        )
      end

      context 'success' do
        it 'should send an email to user' do
          expect(TimeSlot::ServiceDoneMailer).to receive(:send_notification_to_user).exactly(1).times
          service.execute
        end
      end

      context 'failure' do
          let!(:time_slot) { create(:time_slot,
            start_time: Time.zone.now.change(hour: 13, min: 0),
            end_time: Time.zone.now.change(hour: 15, min: 0),
            user: user
          )}

        it 'should send an email to user' do
          expect(TimeSlot::ServiceDoneMailer).to receive(:send_notification_to_user).exactly(0).times
          service.execute
        end
      end
    end
  end
end
