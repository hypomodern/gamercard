require 'faraday'

module Gamercard
  class Client
    attr_accessor :gamertag

    GAMERCARD_SERVICE_URL = "http://gamercard.xbox.com"

    def initialize gamertag
      self.gamertag = gamertag
    end

    def fetch
      response = fetch_with_redirect
      if response.success?
        parse response
      else
        response
      end
    end

    def fetch_with_redirect
      resp = connection.get(build_url)
      if resp.status == 302 && resp['location']
        resp = connection.get(resp['location'])
      end
      resp
    end

    def connection
      @connection ||= Faraday.new(:url => GAMERCARD_SERVICE_URL) do |b|
        b.adapter Gamercard.adapter
      end
    end

    def build_url
      "#{gamertag}.card"
    end

    def parse response
      CardParser.parse response
    end

  end
end