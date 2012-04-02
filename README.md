# Gamercard

Retrieves and parses an Xbox Live Gamercard for a player, providing a hash of the relevant data about the player or the raw HTML.

[![Build Status](https://secure.travis-ci.org/hypomodern/gamercard.png)](http://travis-ci.org/hypomodern/gamercard)

## Installation

Add this line to your application's Gemfile:

    gem 'gamercard'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gamercard

## Usage

Returns a hash suitable for JSON serialization.

```ruby
resp = Gamercard.get('laikal1')
pp resp
# =>
{"gamertag"=>"laikal1",
 "link"=>"http://live.xbox.com/en-US/Profile?Gamertag=laikal1",
 "gamerpic"=>"http://avatar.xboxlive.com/avatar/laikal1/avatarpic-l.png",
 "gamerscore"=>49646,
 "location"=>"Ann Arbor, MI",
 "motto"=>"Complexify!",
 "name"=>"Nyarlathotep (1 bucket)",
 "bio"=>"Design is how it works.",
 "reputation"=>4.25,
 "recent_games"=>
  [{"comparison_url"=>
     "http://live.xbox.com/en-US/Activity/Details?titleId=1161890110&compareTo=laikal1",
    "image"=>
     "http://tiles.xbox.com/tiles/9a/SL/0mdsb2JhbA9ECgQNGwEfV1wmL2ljb24vMC84MDAwIAAAAAAAAP2kpOo=.jpg",
    "title"=>"KoA: Reckoning",
    "last_played"=>"3/29/2012",
    "earned_gamerscore"=>10,
    "available_gamerscore"=>1300,
    "earned_achievements"=>1,
    "available_achievements"=>61,
    "percentage_complete"=>"1%"},
   {"comparison_url"=>
     "http://live.xbox.com/en-US/Activity/Details?titleId=1161890141&compareTo=laikal1",
    "image"=>
     "http://tiles.xbox.com/tiles/np/G2/12dsb2JhbA9ECgQNGwEfV1onL2ljb24vMC84MDAwIAAAAAAAAPiZkYE=.jpg",
    "title"=>"Mass Effect 3",
    "last_played"=>"3/28/2012",
    "earned_gamerscore"=>1025,
    "available_gamerscore"=>1050,
    "earned_achievements"=>51,
    "available_achievements"=>52,
    "percentage_complete"=>"98%"},
   {"comparison_url"=>
     "http://live.xbox.com/en-US/Activity/Details?titleId=1161890083&compareTo=laikal1",
    "image"=>
     "http://tiles.xbox.com/tiles/WQ/nz/0Wdsb2JhbA9ECgQNGwEfV11QL2ljb24vMC84MDAwIAAAAAAAAP7cCUY=.jpg",
    "title"=>"Syndicate",
    "last_played"=>"3/11/2012",
    "earned_gamerscore"=>530,
    "available_gamerscore"=>1000,
    "earned_achievements"=>33,
    "available_achievements"=>50,
    "percentage_complete"=>"66%"},
   {"comparison_url"=>
     "http://live.xbox.com/en-US/Activity/Details?titleId=1414793176&compareTo=laikal1",
    "image"=>
     "http://tiles.xbox.com/tiles/fc/qf/0Wdsb2JhbA9ECgUMGgQfWStbL2ljb24vMC84MDAwIAAAAAAAAP6wymI=.jpg",
    "title"=>"BioShock",
    "last_played"=>"2/25/2012",
    "earned_gamerscore"=>1100,
    "available_gamerscore"=>1100,
    "earned_achievements"=>51,
    "available_achievements"=>51,
    "percentage_complete"=>"100%"},
   {"comparison_url"=>
     "http://live.xbox.com/en-US/Activity/Details?titleId=1112737766&compareTo=laikal1",
    "image"=>
     "http://tiles.xbox.com/tiles/qR/QI/1Gdsb2JhbA9ECgQKGgMfWSpVL2ljb24vMC84MDAwIAAAAAAAAPsnFLY=.jpg",
    "title"=>"Skyrim",
    "last_played"=>"2/14/2012",
    "earned_gamerscore"=>910,
    "available_gamerscore"=>1000,
    "earned_achievements"=>47,
    "available_achievements"=>50,
    "percentage_complete"=>"94%"}]}
```

### Configuration

Gamercard uses [Faraday](https://github.com/technoweenie/faraday), so you can use any http backend that Faraday supports. It assumes [Typhoeus](https://github.com/dbalatero/typhoeus) by default. Tell Gamercard what http library you are using by:

```ruby
Gamercard.adapter = :excon # (or :typhoeus, w/e)
```

A block-style configurator is also available:

```ruby
Gamercard.configure do |c|
  c.adapter = :typhoeus
  c.user_agent = "My Awesome Client"
end
```

## CHANGELOG

* **v0.0.1 Hello World**
  * Returns all the basic gamercard data, sans status. Status can be had from a public site, though, so that is next!

## Thanks to

This project builds on work done by the following people and projects:

* [barisbalic](https://github.com/barisbalic)'s [gamertag](https://github.com/barisbalic/gamertag), which depends on unfortunately unreliable 3rd-party proxies to Microsoft's service. This gem provides less data, but scrapes it directly from http://live.xbox.com &ndash; Straight from the horse's mouth, if you will.

So: thanks a ton to him.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Matt Wilson. See LICENSE for details.