# frozen_string_literal: true

require 'erb'
require 'memo_wise'
require 'redlock'
require 'yaml'

class Schedjewel::Runner
  prepend MemoWise

  def run
    $stdout.sync = true
    Schedjewel.logger.info("Schedjewel is running with PID #{Process.pid}.")

    loop do
      execute_tasks
      sleep(seconds_until_next_minute(Time.now) + 0.001)
    end
  rescue SignalException
    # :nocov:
    Schedjewel.logger.info('Thanks for using Schedjewel! Exiting now.')
    exit(0)
    # :nocov:
  end

  memo_wise \
  def lock_manager
    Redlock::Client.new(
      [Schedjewel.app_redis],
      { retry_count: 0 },
    )
  end

  private

  def execute_tasks
    tasks.each do |task|
      task.run if task.should_run?
    end
  end

  memo_wise \
  def tasks
    Schedjewel.parsed_config_file['jobs'].map do |job_name, schedule_string|
      Schedjewel::Task.new(
        job_name:,
        schedule_string:,
        runner: self,
      )
    end
  end

  def seconds_until_next_minute(time)
    seconds_into_minute = Float(time.sec) + (Float(time) % 1.0)
    60.0 - seconds_into_minute
  end
end
