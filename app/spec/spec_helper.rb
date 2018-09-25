require_relative File.join('..', 'app')

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    HTMLConverter
  end
end