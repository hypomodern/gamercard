module Gamercard
  module Configuration
    # Set a custom User-Agent string (default: Gamercard Gem #{version})
    attr_accessor :user_agent

    # Select a different http library for Faraday to use (default: Typhoeus)
    attr_accessor :adapter

    # Yield self to be able to configure Gamercard
    #
    # Example:
    #
    #   Gamercard.configure do |c|
    #     c.user_agent = "MyCoolApp Gamercard Client v2.51"
    #     c.adapter = :excon
    #   end
    def configure
      yield self
    end

    def user_agent
      @user_agent || "Gamercard Gem #{Gamercard::VERSION}"
    end

    def adapter
      @adapter || :typhoeus
    end
  end
end