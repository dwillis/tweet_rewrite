ENV["RACK_ENV"] = "test"

require File.dirname(__FILE__) + "/../application"

module TestHelpers
  def app;    My::Application.new end
  def body;   last_response.body    end
  def status; last_response.status  end
end

RSpec.configure do |c|
  c.include Rack::Test::Methods
  c.include TestHelpers
end
