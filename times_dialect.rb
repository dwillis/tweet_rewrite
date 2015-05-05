require 'bundler'
require 'yaml'
require 'net/http'
require 'uri'
require 'rubygems'
require 'twitter'
require 'times_wire'
require 'bitly'
include TimesWire
Bundler.require(:default, (ENV['RACK_ENV'] || :development).to_sym)

module TimesDialect
  class Application < Sinatra::Base

    configure do
      @@config = YAML.load_file("config.yml") rescue nil || {}
      TimesWire::Base.api_key = ENV['TIMESWIRE_API_KEY'] || @@config['times_wire_api_key']
      Bitly.use_api_version_3
    end

    get '/' do
      erb :index
    end

    post '/result' do
      @url = params[:url]
      @result_type = params[:result_type] ? params[:result_type] : 'mixed'
      redirect "/show?url=#{@url}&result_type=#{@result_type}"
    end

    get '/show' do
      @result_type = params[:result_type].downcase
      @url = params[:url].split('?').first
      @client = Twitter::REST::Client.new(
          :consumer_key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
          :consumer_secret => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
          :oauth_token => ENV['OAUTH_TOKEN'] || @@config['oauth_token'],
          :oauth_token_secret => ENV['OAUTH_TOKEN_SECRET'] || @@config['oauth_token_secret']
        )
      @bitly = Bitly.new(ENV['BITLY_USER'], ENV['BITLY_API_KEY'])
      if @url.include?('nyti.ms')
        @tw_url = Net::HTTP.get_response(URI.parse(@url))['location'].split('?').first
        @item = Item.url(@tw_url)
        @tweets = @client.search(@url.split('?').first, :result_type => @result_type).reject{|i| i.text.include?(@item.title.split.first(2).join(' '))}.reject{|i| i.text[0..1] == 'RT'}
        tweets2 = @client.search(@tw_url.split('?').first, :result_type => @result_type).reject{|i| i.text.include?(@item.title.split.first(2).join(' '))}.reject{|i| i.text[0..1] == 'RT'}
        tweets2.each do |tweet|
          @tweets << tweet unless @tweets.detect{|t| t.id == tweet.id}
        end
      else
        short_url = @bitly.shorten(@url).short_url
        begin
          @item = Item.url(@url)
        rescue
          @item = MetaInspector.new(@url)
        end
        @tweets = @client.search(@url.split('?').first, :result_type => @result_type).reject{|i| i.text.include?(@item.title.split.first(2).join(' '))}.reject{|i| i.text[0..1] == 'RT'}
        tweets2 = @client.search(short_url.split('?').first, :result_type => @result_type).reject{|i| i.text.include?(@item.title.split.first(2).join(' '))}.reject{|i| i.text[0..1] == 'RT'}
        tweets2.each do |tweet|
          @tweets << tweet unless @tweets.detect{|t| t.id == tweet.id}
        end
      end
      erb :result
    end

  end
end
