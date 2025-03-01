# frozen_string_literal: true

require "test_helper"
require "ostruct"
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
      @client.stub :connection, mock_connection(body: "invalid json", status: 200, success: true) do
        assert_raises(Openf1::Error) { @client.drivers }
      end
    end

    def test_handles_authentication_error
      @client.stub :connection, mock_connection(body: "{}", status: 401, success: false) do
        assert_raises(Openf1::AuthenticationError) { @client.drivers }
      end
    end

    def test_handles_resource_not_found_error
      @client.stub :connection, mock_connection(body: "{}", status: 404, success: false) do
        assert_raises(Openf1::ResourceNotFoundError) { @client.drivers }
      end
    end

    def test_handles_rate_limit_error
      @client.stub :connection, mock_connection(body: "{}", status: 429, success: false) do
        assert_raises(Openf1::RateLimitError) { @client.drivers }
      end
    end

    def test_handles_server_error
      @client.stub :connection, mock_connection(body: "{}", status: 500, success: false) do
        assert_raises(Openf1::ServerError) { @client.drivers }
      end
    end

    def test_handles_generic_error
      @client.stub :connection, mock_connection(body: "{}", status: 422, success: false) do
        assert_raises(Openf1::Error) { @client.drivers }
      end
    end

    private

    def mock_connection(body:, status: 200, success: true)
      mock = Minitest::Mock.new
      response = OpenStruct.new(body: body, status: status, success?: success)
      mock.expect :get, response, [String, Hash]
      mock
    end
  end
end
