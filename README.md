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
# config/schedjewel.yml

config:
  app_redis_db: 0
  sidekiq_redis_db: 1

jobs:
  DataMonitors::Launcher: '**:07'
  SendLogReminderEmails: '**:**'
  TruncateTables: '04:58'
```

## A lower-memory alternative: Skedjewel

[Skedjewel][skedjewel] is a Crystal library with very similar functionality. It's also maintained by
me, @davidrunger.

Installing Skedjewel binaries is less convenient than installing Schedjewel as a gem, but it has the
advantage of using less memory, so you might consider using Skedjewel, instead, if low memory usage
is a priority for you.

[skedjewel]: https://github.com/davidrunger/skedjewel

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `bin/rspec` to run the tests and `bin/rubocop` to run the linter.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidrunger/schedjewel.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
