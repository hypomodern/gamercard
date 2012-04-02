require 'nokogiri'

module Gamercard
  class CardParser
    attr_accessor :raw_response

    def initialize http_response
      self.raw_response = http_response
    end

    def self.parse http_response
      new(http_response).parse
    end

    def parse
      doc = Nokogiri::HTML(raw_response.body)
      gamertag = doc.css("#Gamertag").first
      {
        'gamertag'    => gamertag.content,
        'link'        => gamertag.attribute("href").value,
        'gamerpic'    => doc.css("#Gamerpic").first.attribute("src").value,
        'gamerscore'  => doc.css("#Gamerscore").first.content.to_i,
        'location'    => doc.css("#Location").first.content,
        'motto'       => doc.css("#Motto").first.content,
        'name'        => doc.css("#Name").first.content,
        'bio'         => doc.css("#Bio").first.content,
        'reputation'  => count_reputation(doc),
        'recent_games' => summarize_games(doc)
      }
    end

    def count_reputation doc
      rep = doc.css('.RepContainer')
      counts = {
        1.0  => rep.css('.Full').size,
        0.75 => rep.css('.ThreeQuarter').size,
        0.5  => rep.css('.Half').size,
        0.25 => rep.css('.Quarter').size
      }
      counts.inject(0) do |rep, (value, count)|
        rep += count * value
        rep
      end
    end

    def summarize_games doc
      doc.css('#PlayedGames li').inject([]) do |array, game_node|
        array.push summarize(game_node)
        array
      end
    end

    def summarize game
      link = game.css('a').first
      {
        'comparison_url'         => link.attribute('href').value,
        'image'                  => link.css('img').first.attribute('src').value,
        'title'                  => link.css('.Title').first.content,
        'last_played'            => link.css('.LastPlayed').first.content,
        'earned_gamerscore'      => link.css('.EarnedGamerscore').first.content.to_i,
        'available_gamerscore'   => link.css('.AvailableGamerscore').first.content.to_i,
        'earned_achievements'    => link.css('.EarnedAchievements').first.content.to_i,
        'available_achievements' => link.css('.AvailableAchievements').first.content.to_i,
        'percentage_complete'    => link.css('.PercentageComplete').first.content
      }
    end

  end
end