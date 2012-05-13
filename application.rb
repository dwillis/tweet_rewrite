require 'bundler'
Bundler.require(:default, (ENV['RACK_ENV'] || :development).to_sym)

module My
  class Application < Sinatra::Base
    set :haml, format: :html5

    get '/' do
      haml :index
    end
  end
end
