#!/usr/bin/env ruby

require 'sinatra/base'
require 'erb'

class WikiConverter < Sinatra::Base
  get '/' do
    erb :index, layout: true
  end

  post '/result' do
    params.to_s
  end
end

