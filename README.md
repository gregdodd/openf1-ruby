# Openf1::Ruby

A simple Ruby client for the [OpenF1 API](https://openf1.org/), providing access to Formula 1 timing data, telemetry, and race information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "openf1-ruby"
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install openf1-ruby
```

In your ruby script, add:

```ruby
require 'openf1'
```

## Usage

### Basic Setup

Create a client to interact with the OpenF1 API:

```ruby
client = Openf1::Client.new
```

### Available Endpoints

The client provides access to all OpenF1 API endpoints:

```ruby
client.car_data      # Car telemetry data
client.drivers       # Driver information
client.intervals     # Timing intervals
client.laps          # Lap timing data
client.location      # Track location data
client.meetings      # Race meeting information
client.pit           # Pit stop data
client.position      # Car position data
client.race_control  # Race control messages
client.sessions      # Session information
client.stints        # Stint data
client.team_radio    # Team radio messages
client.weather       # Weather data
```

### Making Requests

All endpoint methods accept optional parameters as a hash:

```ruby
# Get all drivers
client.drivers

# Get drivers for a specific session
client.drivers(session_key: "12345")

# Get sessions for a specific year
client.sessions(year: 2024)

# Get Sprint Sessions for a specific year
client.sessions({year: 2024, session_name: "Sprint"})
```

### Response Format

All responses are returned as OpenStruct objects with data accessible through the `data` attribute:

```ruby
response = client.drivers
response.data.each do |driver|
  puts "#{driver.full_name} (#{driver.driver_number})"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gregdodd/openf1-ruby.
