# frozen_string_literal: true

require 'rack/test'

require_relative File.join('..', 'app')

RSpec.configure do
  include Rack::Test::Methods

  def app
    HTMLConverter.new
  end
end
