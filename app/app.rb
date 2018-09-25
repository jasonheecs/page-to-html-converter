#!/usr/bin/env ruby

require 'sinatra/base'
require 'erb'
require_relative 'helpers/url-parser'

class WikiConverter < Sinatra::Base
  helpers Sinatra::WikiConverter::Helpers

  get '/' do
    erb :index, layout: true
  end

  post '/result' do
    params.to_s
  end
end

