# frozen_string_literal: true

require_relative "openf1/version"
require_relative "openf1/error"
require_relative "openf1/client"

module Openf1
  autoload :Object, "openf1/object"
  autoload :Sessions, "openf1/objects/sessions"
  autoload :CarData, "openf1/objects/car_data"
  autoload :Drivers, "openf1/objects/drivers"
  autoload :Intervals, "openf1/objects/intervals"
  autoload :Laps, "openf1/objects/laps"
  autoload :Location, "openf1/objects/location"
  autoload :Meetings, "openf1/objects/meetings"
  autoload :Pit, "openf1/objects/pit"
  autoload :Position, "openf1/objects/position"
  autoload :RaceControl, "openf1/objects/race_control"
  autoload :Stints, "openf1/objects/stints"
  autoload :TeamRadio, "openf1/objects/team_radio"
  autoload :Weather, "openf1/objects/weather"
end
