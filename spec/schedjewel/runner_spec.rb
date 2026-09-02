# frozen_string_literal: true

RSpec.describe Schedjewel::Runner do
  subject(:runner) { Schedjewel::Runner.new }

  describe '#run' do
    subject(:run) { runner.run }

    before do
      allow(runner).to receive(:loop) do |&block|
        expect { block.call }.not_to raise_error
      end
    end

    after do
      expect(runner).to have_received(:loop).once
    end

    let(:email_reminders_task) do
      # this task is scheduled to run every minute, so it should run regardless of the time
      runner.
        __send__(:tasks).
        detect { it.instance_variable_get(:@job_name) == 'SendLogReminderEmails' }
    end

    it 'runs the tasks that should be run' do
      allow(email_reminders_task).to receive(:run).and_call_original

      # Travel to near the end of a minute (59 seconds) because the #run block will `sleep` until
      # the beginning of the next minute.
      travel_to Time.new(2022, 9, 30, 23, 34, 59) do
        run
      end

      expect(email_reminders_task).to have_received(:run)
    end
  end
end
