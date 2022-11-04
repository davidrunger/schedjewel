# frozen_string_literal: true

RSpec.describe Schedjewel::Schedule do
  subject(:schedule) { Schedjewel::Schedule.new(schedule_string) }

  describe '#matches?' do
    subject(:matches?) { schedule.matches?(time) }

    context 'when the schedule is to run every minute' do
      let(:schedule_string) { '**:**' }
      let(:time) { Time.new }

      it 'matches any time' do
        expect(matches?).to eq(true)
      end
    end

    context 'when the schedule is to run hourly at a certain minute' do
      let(:schedule_string) { '**:22' }

      context 'when the time has that minute' do
        let(:time) { Time.new(2022, 12, 23, 8, 22, 48) }

        it { is_expected.to eq(true) }
      end

      context 'when the time does not have that minute' do
        let(:time) { Time.new(2022, 12, 23, 8, 23, 48) }

        it { is_expected.to eq(false) }
      end
    end

    context 'when the schedule is to run at a specific time' do
      let(:schedule_string) { '02:08' }

      context 'when the time is that time' do
        let(:time) { Time.new(2022, 12, 23, 2, 8, 12) }

        it { is_expected.to eq(true) }
      end

      context 'when the time is not that time' do
        let(:time) { Time.new(2022, 12, 23, 18, 40, 9) }

        it { is_expected.to eq(false) }
      end

      context 'when the schedule string has a double zero hour' do
        let(:schedule_string) { '00:44' }

        context 'when the time is that time' do
          let(:time) { Time.new(2022, 12, 23, 0, 44, 22) }

          it { is_expected.to eq(true) }
        end
      end

      context 'when the schedule string has a double zero minute' do
        let(:schedule_string) { '03:00' }

        context 'when the time is that time' do
          let(:time) { Time.new(2022, 12, 23, 3, 0, 51) }

          it { is_expected.to eq(true) }
        end
      end
    end
  end
end
