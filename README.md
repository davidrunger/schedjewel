# `schedjewel`

Run Sidekiq jobs on a schedule.

## Installation

Add to your `Gemfile`:

```rb
gem 'schedjewel', github: 'davidrunger/schedjewel'
```

Then run:

```
bundle install
```

Then run:

```
bundle binstubs schedjewel
```

Then add this entry to your `Procfile`:

```yml
clock: bin/schedjewel
```

Then create a `schedjewel.yml` schedule / config file as detailed in the next section.

## `schedjewel.yml` schedule / config file

Create a file at `config/schedjewel.yml` specifying the desired jobs schedule.

Example:

```yml
- job: SendLogReminderEmails
  schedule: '**:**' # every minute

- job: DataMonitors::Launcher
  schedule: '**:07' # hourly at 7 minutes after

- job: InvalidRecordsCheck::Launcher
  schedule: '14:23' # daily at 2:23pm in whichever timezone `Time.now` uses
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `bin/rspec` to run the tests and `bin/rubocop` to run the linter.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidrunger/schedjewel.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
