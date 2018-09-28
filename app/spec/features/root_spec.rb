# frozen_string_literal: true

require_relative '../spec_helper'

describe 'GET /' do
  before { get '/' }

  it 'is successful' do
    expect(last_response.ok?).to be true
  end
end
