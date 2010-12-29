$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "scalarium"
require "rspec"
require "webmock/rspec"

def fixture(file_name)
  File.read(fixture_path(file_name))
end

def fixture_path(file_name)
  File.expand_path(File.dirname(__FILE__)) + "/fixtures/#{file_name}"
end

RSpec.configure do |config|
  config.include(WebMock::API)
end