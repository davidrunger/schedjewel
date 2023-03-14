# frozen_string_literal: true

RSpec.describe Schedjewel::Task do
  subject(:task) do
    Schedjewel::Task.new(
      job_name: 'InvalidRecordsCheck::Launcher',
      schedule_string: '23:59',
      runner: Schedjewel::Runner.new,
    )
  end

  describe '#run' do
    subject(:run) { task.run }

    it 'sends a job hash to Redis', :frozen_time do
      expect {
        run
      }.to change {
        JSON(Schedjewel.sidekiq_redis.with { _1.call('lpop', 'queue:default') })
      }.from('null').to({
        'class' => 'InvalidRecordsCheck::Launcher',
        'queue' => 'default',
        'args' => [],
        'retry' => true,
        'jid' => /[0-9a-f]{24}/,
        'created_at' => Time.now.to_f,
        'enqueued_at' => Time.now.to_f,
      })
    end
  end

  describe '#should_run?' do
    subject(:should_run?) { task.should_run? }

    context 'when the schedule matches the current time' do
      before { travel_to Time.new(2022, 9, 30, 23, 59, 10) }

      let(:resource_key) { task.__send__(:resource_key, Time.now) }

      context 'when the task has not been run yet in that minute' do
        before do
          expect(task.lock_manager.locked?(resource_key)).to eq(false)
        end

        it 'returns true' do
          expect(should_run?).to eq(true)
        end
      end

      context 'when the task has already been run in that minute' do
        before do
          task.lock_manager.lock(resource_key, 60_000)
          expect(task.lock_manager.locked?(resource_key)).to eq(true)
        end

        it 'returns false' do
          expect(should_run?).to eq(false)
        end
      end
    end
  end
end
