# frozen_string_literal: true

module SpecHelpers
  def stub_config_file_content
    allow(File).
      to receive(:read).
      with('config/schedjewel.yml').
      and_return(<<~YML)
        config:
          app_redis_db: 0
          sidekiq_redis_db: <%= ENV.fetch('NONEXISTENT_ENV_VAR', -1 * -1) %>

        jobs:
          - job: SendLogReminderEmails
            schedule: '**:**'
          - job: DataMonitors::Launcher
            schedule: '**:07'
          - job: InvalidRecordsCheck::Launcher
            schedule: '01:23'
      YML
  end
end
