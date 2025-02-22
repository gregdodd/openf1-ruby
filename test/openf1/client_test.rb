# frozen_string_literal: true

require "test_helper"

module Openf1
  class ClientTest < Minitest::Test
    def setup
      @client = Openf1::Client.new
    end

    def test_initializes_with_api_key
      client = Openf1::Client.new(api_key: "test-key")
      assert_equal "test-key", client.api_key
    end

    def test_get_request_handles_json_parse_error
      @client.stub :connection, mock_connection(body: "invalid json") do
        assert_raises(Openf1::Error) { @client.drivers }
      end
    end

    private

    def mock_connection(body:)
      mock = Minitest::Mock.new
      response = OpenStruct.new(body: body)
      mock.expect :get, response, [String, Hash]
      mock
    end
  end
end
