require 'spec_helper'

module Gamercard
  describe "CardParser" do
    let(:mock_response) { mock(:body => File.read("spec/fixtures/laikal1.html")) }
    let(:parser) { CardParser.new mock_response }
    let(:doc) { Nokogiri::HTML(mock_response.body) }

    def nokogirize html
      Nokogiri::HTML(html)
    end

    describe ".parse" do
      it "returns a hash representing a parsed gamercard" do
        result = CardParser.parse mock_response
        result['gamertag'].should == 'laikal1'
        result['gamerpic'].should == 'http://avatar.xboxlive.com/avatar/laikal1/avatarpic-l.png'
        result['gamerscore'].should == 49646
      end
    end

    describe "attributes" do
      it "takes one required parameter, viz the http response from the card service" do
        parser = CardParser.new mock_response
        parser.raw_response.should == mock_response
      end
    end

    describe "#parse" do
      it "chops the html up neatly" do
        result = parser.parse
        result['gamertag'].should == 'laikal1'
        result['gamerpic'].should == 'http://avatar.xboxlive.com/avatar/laikal1/avatarpic-l.png'
        result['gamerscore'].should == 49646
        result['recent_games'].size.should == 5
      end
    end

    describe "#count_reputation" do
      it "returns laikal1's rep as 4.25" do
        count = parser.count_reputation(doc).should == 4.25
      end
      it "counts the number of Full, Half, ThreeQuarter, and Quarter .Star elements in the .RepContainer" do
        doc1 = <<-DOC1
          <div class="RepContainer">
            <label>Rep</label>
            <div class="Star Full"></div>
            <div class="Star Full"></div>
            <div class="Star Full"></div>
            <div class="Star ThreeQuarter"></div>
            <div class="Star Empty"></div>
          </div>
        DOC1
        parser.count_reputation(nokogirize(doc1)).should == 3.75

        doc2 = <<-DOC2
          <div class="RepContainer">
            <label>Rep</label>
            <div class="Star Full"></div>
            <div class="Star Full"></div>
            <div class="Star Half"></div>
            <div class="Star Empty"></div>
            <div class="Star Empty"></div>
          </div>
        DOC2
        parser.count_reputation(nokogirize(doc2)).should == 2.5

        doc3 = <<-DOC3
          <div class="RepContainer">
            <label>Rep</label>
            <div class="Star Full"></div>
            <div class="Star Empty"></div>
            <div class="Star Half"></div>
            <div class="Star Quarter"></div>
            <div class="Star Empty"></div>
          </div>
        DOC3
        parser.count_reputation(nokogirize(doc3)).should == 1.75
      end
    end

    describe "#summarize_games" do
      it "returns an array of game summaries" do
        games = parser.summarize_games(doc)
        games.should be_a_kind_of(Array)
        games.size.should == 5
      end
    end

    describe "#summarize" do
      it "returns a hash of parsed values" do
        game = <<-DOC
          <li >
              <a href="http://live.xbox.com/en-US/Activity/Details?titleId=1161890110&amp;compareTo=laikal1">
                 <img src="http://tiles.xbox.com/tiles/9a/SL/0mdsb2JhbA9ECgQNGwEfV1wmL2ljb24vMC84MDAwIAAAAAAAAP2kpOo=.jpg" alt="KoA: Reckoning" title="KoA: Reckoning" />
                 <span class="Title">KoA: Reckoning</span>
                 <span class="LastPlayed">3/28/2012</span>
                 <span class="EarnedGamerscore">10</span>
                 <span class="AvailableGamerscore">1300</span>
                 <span class="EarnedAchievements">1</span>
                 <span class="AvailableAchievements">61</span>
                 <span class="PercentageComplete">1%</span>
              </a>
          </li>
        DOC
        result = parser.summarize(nokogirize(game))
        result.should == {
          "comparison_url"         => "http://live.xbox.com/en-US/Activity/Details?titleId=1161890110&compareTo=laikal1",
          "image"                  => "http://tiles.xbox.com/tiles/9a/SL/0mdsb2JhbA9ECgQNGwEfV1wmL2ljb24vMC84MDAwIAAAAAAAAP2kpOo=.jpg",
          "title"                  => "KoA: Reckoning",
          "last_played"            => "3/28/2012",
          "earned_gamerscore"      => 10,
          "available_gamerscore"   => 1300,
          "earned_achievements"    => 1,
          "available_achievements" => 61,
          "percentage_complete"    => "1%"
        }
      end
    end

  end
end