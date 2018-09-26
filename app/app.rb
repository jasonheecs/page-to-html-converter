#!/usr/bin/env ruby

require 'sinatra/base'
require 'down'
require 'erb'
require 'uri'
require_relative 'helpers/url-parser'

class HTMLConverter < Sinatra::Base
  helpers Sinatra::HTMLConverter::Helpers::URLParser

  get '/' do
    erb :index, layout: true
  end

  post '/result' do
    halt 422 unless params.key?(:url)
    html = get_body(params[:url])
    erb :result, locals: { html: html }, layout: true
  end

  error URI::InvalidURIError, URI::BadURIError, Down::Error do
    halt 400
  end
end
