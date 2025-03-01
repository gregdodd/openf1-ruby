# frozen_string_literal: true

module Openf1
  class Error < StandardError; end
  class AuthenticationError < Error; end
  class RateLimitError < Error; end
  class ResourceNotFoundError < Error; end
  class ServerError < Error; end
end
