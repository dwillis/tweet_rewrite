require 'bundler'
Bundler.require(:default, (ENV['RACK_ENV'] || :development).to_sym)

module My
  class Application < Sinatra::Base
    get '/' do
      haml :index
    end
  end
end
