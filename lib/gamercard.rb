require "gamercard/version"
require "gamercard/configuration"
require "gamercard/client"
require "gamercard/card_parser"

module Gamercard
  extend Configuration

  def self.get gamertag
    Client.new(gamertag).fetch
  end
end
