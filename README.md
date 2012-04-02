# Gamercard

Retrieves and parses an Xbox Live Gamercard for a player, providing a hash of the relevant data about the player or the raw HTML.

## Installation

Add this line to your application's Gemfile:

    gem 'gamercard'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gamercard

## Usage

TODO: Write usage instructions here

## Thanks to

This project builds on work done by the following people and projects:

* [barisbalic](https://github.com/barisbalic)'s [gamertag](https://github.com/barisbalic/gamertag), which depends on unfortunately unreliable 3rd-party proxies to Microsoft's service. This gem provides less data, but scrapes it directly from http://live.xbox.com

So: thanks a ton to him.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Matt Wilson. See LICENSE for details.