# frozen_string_literal: true

require "faraday"

module Openf1
  class Client
    attr_accessor :api_key

    BASE_URL = "https://api.openf1.org/v1"

    def initialize(api_key: nil)
      @api_key = api_key
    end

    def car_data(params = {})
      CarData.new(get_request("car_data", params))
    end

    def drivers(params = {})
      Drivers.new(get_request("drivers", params))
    end

    def intervals(params = {})
      Intervals.new(get_request("intervals", params))
    end

    def laps(params = {})
      Laps.new(get_request("laps", params))
    end

    def location(params = {})
      Location.new(get_request("location", params))
    end

    def meetings(params = {})
      Meetings.new(get_request("meetings", params))
    end

    def pit(params = {})
      Pit.new(get_request("pit", params))
    end

    def position(params = {})
      Position.new(get_request("position", params))
    end

    def race_control(params = {})
      RaceControl.new(get_request("race-control", params))
    end

    def sessions(params = {})
      Sessions.new(get_request("sessions", params))
    end

    def stints(params = {})
      Stints.new(get_request("stints", params))
    end

    def team_radio(params = {})
      TeamRadio.new(get_request("team-radio", params))
    end

    def weather(params = {})
      Weather.new(get_request("weather", params))
    end

    private

    def get_request(endpoint, params = {})
      response = connection.get("#{BASE_URL}/#{endpoint}", params)
      handle_error_response(response) unless response.success?
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      raise Openf1::Error, "Failed to parse API response: #{e.message}"
    end

    def handle_error_response(response)
      case response.status
      when 401 then raise Openf1::AuthenticationError, "Invalid API key"
      when 404 then raise Openf1::ResourceNotFoundError, "Resource not found"
      when 429 then raise Openf1::RateLimitError, "Rate limit exceeded"
      when 500..599 then raise Openf1::ServerError, "Server error: #{response.status}"
      else raise Openf1::Error, "API error: #{response.status}"
      end
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.headers["Authorization"] = "Bearer #{api_key}" if api_key
        conn.headers["Content-Type"] = "application/json"
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
