## Description
Yet another opinionated [sinatra app bootstrapped with
bootstrap](https://github.com/search?langOverride=&q=sinatra-bootstrap&repo=&start_value=1&type=Repositories&utf8=%E2%9C%93).
This one comes with haml, rspec and rack-test setup, a syncable bootstrap, a default layout and ready for heroku.

## Setup

```sh
$ git clone git://github.com/cldwalker/sinatra-bootstrap.git my_app
$ cd my_app
$ bundle install
```

App is named My::Application by default. Rename as desired (Yes, Sinatra::Application exists but
screw top-level extensions).

## Usage

```sh
# In dev
$ bundle exec shotgun
# In production
$ bundle exec thin start
# To herokuify
$ heroku create -s cedar && heroku open
```

## Using bootstrap

Bootstrap files are available under public/bootstrap/{css,img,js}. The layout, views/layout.haml,
points to those files. If you'd like to update public/bootstrap to the latest bootstrap version:

```sh
# Only do this once
$ rake bootstrap:init

# Run this every time
$ rake bootstrap:update
```

If lessc and uglifyjs are installed, the update task will compile the assets into a zip file. Otherwise, it'll use
the prebuilt assets.

## TODO
* Replace git submodule with a temp clone
* Setup airbrake with errbit
* Setup coffeescript with testing
* Gemify useful components as needed
* Consider scss/less

## Credits
* [twitter bootstrap](http://github.com/twitter/bootstrap) of course
* [bootstrap rake
  tasks](https://github.com/gudleik/twitter-bootstrapped)
* [view layout](https://github.com/ghostandthemachine/sinatra-haml-bootstrap-fluid)
