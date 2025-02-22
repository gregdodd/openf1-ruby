# frozen_string_literal: true

require "test_helper"

module Openf1
  class DriversTest < Minitest::Test
    def test_inherits_from_object
      assert_kind_of Openf1::Object, Openf1::Drivers.new([])
    end

    def test_creates_driver_objects
      data = [
        { "driver_number" => "44", "full_name" => "Lewis Hamilton" },
        { "driver_number" => "1", "full_name" => "Max Verstappen" }
      ]
      drivers = Openf1::Drivers.new(data)

      assert_equal "44", drivers.data.first.driver_number
      assert_equal "Lewis Hamilton", drivers.data.first.full_name
      assert_equal "Max Verstappen", drivers.data.last.full_name
    end
  end
end
