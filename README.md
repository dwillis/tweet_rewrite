## Times Dialect

A Ruby app that, given the URL of a New York Times article or blog post, returns tweets from the Twitter API that do not include the article or post's title. In other words, it finds tweets that reference NYT stories but in a different way. It uses the Twitter API, Sinatra and the Times Wire gem. [See it in action](http://tweetrewrite.herokuapp.com/).

## Setup

You'll need to fill in the values in config.yml.example, including an API key for the New York Times [Newswire API](http://developer.nytimes.com/docs/read/times_newswire_api). If you are deploying to Heroku, use Heroku's config:add command to add these as environment values.

## Authors
* Derek Willis, dwillis@nytimes.com

## Copyright

Copyright (c) 2014 The New York Times Company. See LICENSE for details.

## Credits
* [sinatra bootstrap](https://github.com/cldwalker/sinatra-bootstrap) 
