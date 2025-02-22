# frozen_string_literal: true

require "test_helper"

module Openf1
  class ObjectTest < Minitest::Test
    def test_raises_error_when_attributes_nil
      assert_raises(ArgumentError) { Openf1::Object.new(nil) }
    end

    def test_converts_hash_to_ostruct
      obj = Openf1::Object.new({ "name" => "Test", "value" => 123 })
      assert_kind_of OpenStruct, obj.data
      assert_equal "Test", obj.data.name
      assert_equal 123, obj.data.value
    end

    def test_handles_nested_hashes
      obj = Openf1::Object.new({
                                 "driver" => {
                                   "name" => "Lewis Hamilton",
                                   "number" => 44
                                 }
                               })
      assert_kind_of OpenStruct, obj.data.driver
      assert_equal "Lewis Hamilton", obj.data.driver.name
      assert_equal 44, obj.data.driver.number
    end

    def test_handles_arrays
      obj = Openf1::Object.new([
                                 { "name" => "Driver 1" },
                                 { "name" => "Driver 2" }
                               ])
      assert_kind_of Array, obj.data
      assert_kind_of OpenStruct, obj.data.first
      assert_equal "Driver 1", obj.data.first.name
      assert_equal "Driver 2", obj.data.last.name
    end
  end
end
