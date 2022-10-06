# frozen_string_literal: true

RSpec.describe Schedjewel::Runner do
  subject(:runner) { Schedjewel::Runner.new }

  describe '#run' do
    subject(:run) { runner.run }

    before do
      expect(runner).to receive(:loop) do |&block|
        expect { block.call }.not_to raise_error
      end

      expect(File).to receive(:read).with('config/schedjewel.yml').and_return(<<~YML)
        - job: SendLogReminderEmails
          schedule: '**:**' # every minute

        - job: DataMonitors::Launcher
          schedule: '**:07' # hourly at 7 minutes after

        - job: InvalidRecordsCheck::Launcher
          schedule: '14:23' # daily at 2:23pm in whichever timezone `Time.now` uses
      YML
    end

    let(:email_reminders_task) do
      # this task is scheduled to run every minute, so it should run regardless of the time
      runner.
        __send__(:tasks).
        detect { _1.instance_variable_get(:@job_name) == 'SendLogReminderEmails' }
    end

    it 'runs the tasks that should be run' do
      expect(email_reminders_task).to receive(:run).and_call_original

      # Travel to near the end of a minute (59 seconds) because the #run block will `sleep` until
      # the beginning of the next minute.
      travel_to Time.new(2022, 9, 30, 23, 34, 59) do
        run
      end
    end
  end
end
