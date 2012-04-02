require 'spec_helper'

module Gamercard
  describe "Client" do
    let(:client) { Client.new("laikal1") }

    it "should be loaded correctly" do
      lambda { Gamercard::Client }.should_not raise_error
    end

    it "takes the gamertag as the only input parameter" do
      client.gamertag.should == "laikal1"
    end

    describe "#fetch" do
      it "should return a hash of useful values" do
        VCR.use_cassette('fetch_laikal1', :record => :new_episodes) do
          response = client.fetch
          response['gamertag'].should == 'laikal1'
          response['gamerpic'].should == 'http://avatar.xboxlive.com/avatar/laikal1/avatarpic-l.png'
          response['gamerscore'].should == 49646
          response['recent_games'].size.should == 5
        end
      end
      it "should return the raw response if there is a problem with the response" do
        client.stub!(:connection).and_return(
          Faraday.new do |builder|
            builder.adapter :test do |stub|
              stub.get('laikal1.card') {[ 500, {}, 'Oh Noes! I blew it up!' ]}
            end
          end
        )
        VCR.turned_off do
          response = client.fetch
          response.status.should == 500
          response.body.should == 'Oh Noes! I blew it up!'
        end
      end
    end

    describe "#fetch_with_redirect" do
      it "follows the redirect like a boss" do
        VCR.use_cassette('fetch_laikal1', :record => :new_episodes) do
          response = client.fetch_with_redirect
          response.status.should == 200
          response.body[0, 16].should == "\r\n<!DOCTYPE html"
        end
      end
    end

    describe "#connection" do
      it "returns a Faraday connection, using the configured http library, to the gamercard url" do
        conn = client.send(:connection)
        conn.host.should == Client::GAMERCARD_SERVICE_URL.sub("http://", "")
        conn.builder.handlers.should include(Faraday::Adapter::Typhoeus)
      end
    end

    describe "#build_url" do
      it "returns the portion of the URL that generates the card for the given gamertag" do
        client.build_url.should == "laikal1.card"
      end
    end

    describe "#parse" do
      it "delegates to a CardParser object" do
        CardParser.should_receive(:parse).with("foo").and_return({ "gamertag" => "laikal1" })
        client.parse "foo"
      end
    end

  end
end