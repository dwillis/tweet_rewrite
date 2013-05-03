require 'bundler'
require 'yaml'
require 'rubygems'
require 'twitter'
require 'times_wire'
include TimesWire
Bundler.require(:default, (ENV['RACK_ENV'] || :development).to_sym)

module TimesDialect
  class Application < Sinatra::Base
    
    configure do
      @@config = YAML.load_file("config.yml") rescue nil || {}
      TimesWire::Base.api_key = @@config['times_wire_api_key']
    end
    
    get '/' do
      erb :index
    end
    
    post '/result' do
      @url = params[:url]
      redirect "/show?url=#{@url}"
    end

    get '/show' do
      @client = Twitter::Client.new(
          :consumer_key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
          :consumer_secret => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
          :oauth_token => @@config['oauth_token'],
          :oauth_token_secret => @@config['oauth_token_secret']
        )
      @url = params[:url].split('?').first
      @item = Item.url(@url)
      @tweets = @client.search(@item.url).statuses.reject{|i| i.text.include?(@item.title.split.first(5).join(' '))}.reject{|i| i.text[0..1] == 'RT'}
      erb :result
    end
    
  end
end
